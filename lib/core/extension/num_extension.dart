import 'package:booksea/ui/shared/size_fit.dart';

extension NumFit on num {
  double get px {
    return SizeFit.setPx(this.toDouble());
  }

  double get rpx {
    return SizeFit.setRpx(this.toDouble());
  }
}