import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zen8app/lib.dart';

typedef RxBuilderFunc<T> = Widget Function(
    BuildContext context, ConnectionState connectionState, T data);

class RxBuilder {
  RxBuilder._();

  static Widget from<T>({
    Key? key,
    T? initialData,
    required Stream<T> stream,
    required RxBuilderFunc<T?> builder,
  }) {
    return StreamBuilder<T>(
      key: key,
      stream: stream,
      builder: (context, snapshot) => builder(
          context, snapshot.connectionState, snapshot.data ?? initialData),
    );
  }

  static Widget combine2<T0, T1>({
    Key? key,
    required Stream<T0> s0,
    required Stream<T1> s1,
    required RxBuilderFunc<Tuple<T0?, T1?>> builder,
  }) {
    final combinedStream =
        Rx.combineLatest2(s0, s1, (T0 $0, T1 $1) => Tuple($0, $1));
    return from<Tuple<T0, T1>>(
      key: key,
      stream: combinedStream,
      builder: (context, connectionState, data) =>
          builder(context, connectionState, Tuple(data?.$0, data?.$1)),
    );
  }

  static Widget combine3<T0, T1, T2>({
    Key? key,
    required Stream<T0> s0,
    required Stream<T1> s1,
    required Stream<T2> s2,
    required RxBuilderFunc<Tuple3<T0?, T1?, T2?>> builder,
  }) {
    final combinedStream = Rx.combineLatest3(
        s0, s1, s2, (T0 $0, T1 $1, T2 $2) => Tuple3($0, $1, $2));
    return from<Tuple3<T0, T1, T2>>(
      key: key,
      stream: combinedStream,
      builder: (context, connectionState, data) => builder(
          context, connectionState, Tuple3(data?.$0, data?.$1, data?.$2)),
    );
  }

  static Widget combine4<T0, T1, T2, T3>({
    Key? key,
    required Stream<T0> s0,
    required Stream<T1> s1,
    required Stream<T2> s2,
    required Stream<T3> s3,
    required RxBuilderFunc<Tuple4<T0?, T1?, T2?, T3?>> builder,
  }) {
    final combinedStream = Rx.combineLatest4(
        s0, s1, s2, s3, (T0 $0, T1 $1, T2 $2, T3 $3) => Tuple4($0, $1, $2, $3));
    return from<Tuple4<T0, T1, T2, T3>>(
      key: key,
      stream: combinedStream,
      builder: (context, connectionState, data) => builder(context,
          connectionState, Tuple4(data?.$0, data?.$1, data?.$2, data?.$3)),
    );
  }

  static Widget combine5<T0, T1, T2, T3, T4>({
    Key? key,
    required Stream<T0> s0,
    required Stream<T1> s1,
    required Stream<T2> s2,
    required Stream<T3> s3,
    required Stream<T4> s4,
    required RxBuilderFunc<Tuple5<T0?, T1?, T2?, T3?, T4?>> builder,
  }) {
    final combinedStream = Rx.combineLatest5(s0, s1, s2, s3, s4,
        (T0 $0, T1 $1, T2 $2, T3 $3, T4 $4) => Tuple5($0, $1, $2, $3, $4));
    return from<Tuple5<T0, T1, T2, T3, T4>>(
      key: key,
      stream: combinedStream,
      builder: (context, connectionState, data) => builder(
          context,
          connectionState,
          Tuple5(data?.$0, data?.$1, data?.$2, data?.$3, data?.$4)),
    );
  }

  static Widget combine6<T0, T1, T2, T3, T4, T5>({
    Key? key,
    required Stream<T0> s0,
    required Stream<T1> s1,
    required Stream<T2> s2,
    required Stream<T3> s3,
    required Stream<T4> s4,
    required Stream<T5> s5,
    required RxBuilderFunc<Tuple6<T0?, T1?, T2?, T3?, T4?, T5?>> builder,
  }) {
    final combinedStream = Rx.combineLatest6(
        s0,
        s1,
        s2,
        s3,
        s4,
        s5,
        (T0 $0, T1 $1, T2 $2, T3 $3, T4 $4, T5 $5) =>
            Tuple6($0, $1, $2, $3, $4, $5));
    return from<Tuple6<T0, T1, T2, T3, T4, T5>>(
      key: key,
      stream: combinedStream,
      builder: (context, connectionState, data) => builder(
          context,
          connectionState,
          Tuple6(data?.$0, data?.$1, data?.$2, data?.$3, data?.$4, data?.$5)),
    );
  }

  static Widget combine7<T0, T1, T2, T3, T4, T5, T6>({
    Key? key,
    required Stream<T0> s0,
    required Stream<T1> s1,
    required Stream<T2> s2,
    required Stream<T3> s3,
    required Stream<T4> s4,
    required Stream<T5> s5,
    required Stream<T6> s6,
    required RxBuilderFunc<Tuple7<T0?, T1?, T2?, T3?, T4?, T5?, T6?>> builder,
  }) {
    final combinedStream = Rx.combineLatest7(
        s0,
        s1,
        s2,
        s3,
        s4,
        s5,
        s6,
        (T0 $0, T1 $1, T2 $2, T3 $3, T4 $4, T5 $5, T6 $6) =>
            Tuple7($0, $1, $2, $3, $4, $5, $6));
    return from<Tuple7<T0, T1, T2, T3, T4, T5, T6>>(
      key: key,
      stream: combinedStream,
      builder: (context, connectionState, data) => builder(
          context,
          connectionState,
          Tuple7(data?.$0, data?.$1, data?.$2, data?.$3, data?.$4, data?.$5,
              data?.$6)),
    );
  }

  static Widget combine8<T0, T1, T2, T3, T4, T5, T6, T7>({
    Key? key,
    required Stream<T0> s0,
    required Stream<T1> s1,
    required Stream<T2> s2,
    required Stream<T3> s3,
    required Stream<T4> s4,
    required Stream<T5> s5,
    required Stream<T6> s6,
    required Stream<T7> s7,
    required RxBuilderFunc<Tuple8<T0?, T1?, T2?, T3?, T4?, T5?, T6?, T7?>>
        builder,
  }) {
    final combinedStream = Rx.combineLatest8(
        s0,
        s1,
        s2,
        s3,
        s4,
        s5,
        s6,
        s7,
        (T0 $0, T1 $1, T2 $2, T3 $3, T4 $4, T5 $5, T6 $6, T7 $7) =>
            Tuple8($0, $1, $2, $3, $4, $5, $6, $7));
    return from<Tuple8<T0, T1, T2, T3, T4, T5, T6, T7>>(
      key: key,
      stream: combinedStream,
      builder: (context, connectionState, data) => builder(
          context,
          connectionState,
          Tuple8(data?.$0, data?.$1, data?.$2, data?.$3, data?.$4, data?.$5,
              data?.$6, data?.$7)),
    );
  }

  static Widget combine9<T0, T1, T2, T3, T4, T5, T6, T7, T8>({
    Key? key,
    required Stream<T0> s0,
    required Stream<T1> s1,
    required Stream<T2> s2,
    required Stream<T3> s3,
    required Stream<T4> s4,
    required Stream<T5> s5,
    required Stream<T6> s6,
    required Stream<T7> s7,
    required Stream<T8> s8,
    required RxBuilderFunc<Tuple9<T0?, T1?, T2?, T3?, T4?, T5?, T6?, T7?, T8?>>
        builder,
  }) {
    final combinedStream = Rx.combineLatest9(
        s0,
        s1,
        s2,
        s3,
        s4,
        s5,
        s6,
        s7,
        s8,
        (T0 $0, T1 $1, T2 $2, T3 $3, T4 $4, T5 $5, T6 $6, T7 $7, T8 $8) =>
            Tuple9($0, $1, $2, $3, $4, $5, $6, $7, $8));
    return from<Tuple9<T0, T1, T2, T3, T4, T5, T6, T7, T8>>(
      key: key,
      stream: combinedStream,
      builder: (context, connectionState, data) => builder(
          context,
          connectionState,
          Tuple9(data?.$0, data?.$1, data?.$2, data?.$3, data?.$4, data?.$5,
              data?.$6, data?.$7, data?.$8)),
    );
  }
}
