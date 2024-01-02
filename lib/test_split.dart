import 'dart:math';


Tensor testSplitFn(imageProcessDef, L, {int refield = 32, int minSize = 256, int sf = 1, int modulo = 1}) {
  /*
  model:
  L: input Low-quality image
  refield: effective receptive filed of the network, 32 is enough
  min_size: min_sizeXmin_size image, e.g., 256X256 image
  sf: scale factor for super-resolution, otherwise 1
  modulo: 1 if split
  */
  var h = L.size()[-2];
  var w = L.size()[-1];

  if (h * w <= pow(minSize, 2)) {
    L = ReplicationPad2d([0, (ceil(w / modulo) * modulo - w).toInt(), 0, (ceil(h / modulo) * modulo - h).toInt()]).call(L);
    var E = imageProcessDef(L);
    E = E[..., range(h * sf), range(w * sf)];
  } else {
  var top = range((h ~/ 2 ~/ refield + 1) * refield);
  var bottom = range(h - ((h ~/ 2 ~/ refield + 1) * refield), h);
  var left = range((w ~/ 2 ~/ refield + 1) * refield);
  var right = range(w - ((w ~/ 2 ~/ refield + 1) * refield), w);

  var Ls = [L[..., top, left], L[..., top, right], L[..., bottom, left], L[..., bottom, right]];

  if (h * w <= 4 * pow(minSize, 2)) {
  var Es = [imageProcessDef(Ls[i]) for (var i = 0; i < 4; i++)];
  } else {
  var Es = [testSplitFn(imageProcessDef, Ls[i], refield: refield, minSize: minSize, sf: sf, modulo: modulo) for (var i = 0; i < 4; i++)];
  }

  var b = Es[0].size()[0];
  var c = Es[0].size()[1];
  var E = Tensor.zeros([b, c, sf * h, sf * w], dtype: L.dtype);

  E[..., range(h ~/ 2 * sf), range(w ~/ 2 * sf)] = Es[0][..., range(h ~/ 2 * sf), range(w ~/ 2 * sf)];
  E[..., range(h ~/ 2 * sf), range(w ~/ 2 * sf, w * sf)] = Es[1][..., range(h ~/ 2 * sf), range(-w + w ~/ 2 * sf, 0)];
  E[..., range(h ~/ 2 * sf, h * sf), range(w ~/ 2 * sf)] = Es[2][..., range(-h + h ~/ 2 * sf, 0), range(w ~/ 2 * sf)];
  E[..., range(h ~/ 2 * sf, h * sf), range(w ~/ 2 * sf, w * sf)] = Es[3][..., range(-h + h ~/ 2 * sf, 0), range(-w + w ~/ 2 * sf, 0)];
  }

  return E;
}
