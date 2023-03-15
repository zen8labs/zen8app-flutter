class Tuple<T0, T1> {
  final T0 $0;
  final T1 $1;

  Tuple(this.$0, this.$1);
}

class Tuple3<T0, T1, T2> extends Tuple<T0, T1> {
  final T2 $2;
  Tuple3(T0 $0, T1 $1, this.$2) : super($0, $1);
}

class Tuple4<T0, T1, T2, T3> extends Tuple3<T0, T1, T2> {
  final T3 $3;
  Tuple4(T0 $0, T1 $1, T2 $2, this.$3) : super($0, $1, $2);
}

class Tuple5<T0, T1, T2, T3, T4> extends Tuple4<T0, T1, T2, T3> {
  final T4 $4;
  Tuple5(T0 $0, T1 $1, T2 $2, T3 $3, this.$4) : super($0, $1, $2, $3);
}

class Tuple6<T0, T1, T2, T3, T4, T5> extends Tuple5<T0, T1, T2, T3, T4> {
  final T5 $5;
  Tuple6(T0 $0, T1 $1, T2 $2, T3 $3, T4 $4, this.$5)
      : super($0, $1, $2, $3, $4);
}

class Tuple7<T0, T1, T2, T3, T4, T5, T6>
    extends Tuple6<T0, T1, T2, T3, T4, T5> {
  final T6 $6;
  Tuple7(T0 $0, T1 $1, T2 $2, T3 $3, T4 $4, T5 $5, this.$6)
      : super($0, $1, $2, $3, $4, $5);
}

class Tuple8<T0, T1, T2, T3, T4, T5, T6, T7>
    extends Tuple7<T0, T1, T2, T3, T4, T5, T6> {
  final T7 $7;
  Tuple8(T0 $0, T1 $1, T2 $2, T3 $3, T4 $4, T5 $5, T6 $6, this.$7)
      : super($0, $1, $2, $3, $4, $5, $6);
}

class Tuple9<T0, T1, T2, T3, T4, T5, T6, T7, T8>
    extends Tuple8<T0, T1, T2, T3, T4, T5, T6, T7> {
  final T8 $8;
  Tuple9(T0 $0, T1 $1, T2 $2, T3 $3, T4 $4, T5 $5, T6 $6, T7 $7, this.$8)
      : super($0, $1, $2, $3, $4, $5, $6, $7);
}
