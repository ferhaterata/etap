; ModuleID = 'test/r/input/foo.ll'
source_filename = "./input/foo.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [11 x i8] c"x - y != 0\00", align 1, !global !0
@.str.1 = private unnamed_addr constant [14 x i8] c"./input/foo.c\00", align 1, !global !1
@__PRETTY_FUNCTION__.foobar = private unnamed_addr constant [22 x i8] c"void foobar(int, int)\00", align 1, !global !2
@__PRETTY_FUNCTION__.foobar1 = private unnamed_addr constant [23 x i8] c"void foobar1(int, int)\00", align 1, !global !3

; Function Attrs: alwaysinline nounwind uwtable
define dso_local double @foo(double %x, double %y) #0 !distribution !6 !distribution !7 !store !8 !formal !6 !formal !7 {
entry:
  %add = fadd double %y, 6.000000e+00, !store !9
  %cmp = fcmp olt double %x, %add, !store !10
  br i1 %cmp, label %if.then, label %if.end4, !store !11

if.then:                                          ; preds = %entry
  %mul = fmul double 2.000000e+00, %y, !store !12
  %cmp1 = fcmp ogt double %mul, -2.000000e+00, !store !13
  br i1 %cmp1, label %if.then2, label %if.end, !store !14

if.then2:                                         ; preds = %if.then
  %mul3 = fmul double %x, %y, !store !15
  br label %return, !store !16

if.end:                                           ; preds = %if.then
  br label %if.end4, !store !17

if.end4:                                          ; preds = %if.end, %entry
  br label %return, !store !16

return:                                           ; preds = %if.end4, %if.then2
  %retval.0 = phi double [ %mul3, %if.then2 ], [ %x, %if.end4 ], !store !18
  ret double %retval.0, !store !19
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @bar(i32 %x, i32 %y) #1 !distribution !20 !distribution !21 !store !8 !formal !20 !formal !21 {
entry:
  %retval = alloca i32, align 4, !store !22
  %x.addr = alloca i32, align 4, !store !23
  %y.addr = alloca i32, align 4, !store !24
  %a = alloca i32, align 4, !store !25
  store i32 %x, i32* %x.addr, align 4, !store !26
  store i32 %y, i32* %y.addr, align 4, !store !27
  %0 = load i32, i32* %x.addr, align 4, !store !28
  %1 = load i32, i32* %y.addr, align 4, !store !29
  %add = add nsw i32 %1, 6, !store !30
  %cmp = icmp slt i32 %0, %add, !store !31
  br i1 %cmp, label %if.then, label %if.end4, !store !11

if.then:                                          ; preds = %entry
  %2 = load i32, i32* %y.addr, align 4, !store !32
  %mul = mul nsw i32 2, %2, !store !33
  store i32 %mul, i32* %a, align 4, !store !34
  %3 = load i32, i32* %a, align 4, !store !35
  %cmp1 = icmp sge i32 %3, 8, !store !36
  br i1 %cmp1, label %if.then2, label %if.end, !store !14

if.then2:                                         ; preds = %if.then
  %4 = load i32, i32* %x.addr, align 4, !store !37
  %5 = load i32, i32* %y.addr, align 4, !store !38
  %mul3 = mul nsw i32 %4, %5, !store !39
  store i32 %mul3, i32* %retval, align 4, !store !40
  br label %return, !store !16

if.end:                                           ; preds = %if.then
  br label %if.end4, !store !17

if.end4:                                          ; preds = %if.end, %entry
  %6 = load i32, i32* %x.addr, align 4, !store !41
  store i32 %6, i32* %retval, align 4, !store !42
  br label %return, !store !16

return:                                           ; preds = %if.end4, %if.then2
  %7 = load i32, i32* %retval, align 4, !store !43
  ret i32 %7, !store !44
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local double @baz(double %x, double %y) #1 !distribution !6 !distribution !7 !store !45 !formal !6 !formal !7 {
entry:
  %retval.i = alloca double, align 8, !store !46
  %x.addr.i = alloca double, align 8, !store !47
  %y.addr.i = alloca double, align 8, !store !48
  %a.i = alloca double, align 8, !store !49
  %x.addr = alloca double, align 8, !store !50
  %y.addr = alloca double, align 8, !store !51
  %z = alloca double, align 8, !store !52
  %i = alloca i32, align 4, !store !53
  store double %x, double* %x.addr, align 8, !store !26
  store double %y, double* %y.addr, align 8, !store !27
  store double 0.000000e+00, double* %z, align 8, !store !54
  store i32 1, i32* %i, align 4, !store !55
  br label %for.cond, !store !56

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4, !store !57
  %cmp = icmp slt i32 %0, 3, !store !58
  br i1 %cmp, label %for.body, label %for.end, !store !59

for.body:                                         ; preds = %for.cond
  %1 = load double, double* %x.addr, align 8, !store !60
  %2 = load double, double* %y.addr, align 8, !store !32
  store double %1, double* %x.addr.i, align 8, !store !61
  store double %2, double* %y.addr.i, align 8, !store !62
  %3 = load double, double* %x.addr.i, align 8, !store !63
  %4 = load double, double* %y.addr.i, align 8, !store !64
  %add.i = fadd double %4, 6.000000e+00, !store !65
  %cmp.i = fcmp olt double %3, %add.i, !store !66
  br i1 %cmp.i, label %if.then.i, label %if.end4.i, !store !67

if.then.i:                                        ; preds = %for.body
  %5 = load double, double* %y.addr.i, align 8, !store !68
  %mul.i = fmul double 2.000000e+00, %5, !store !69
  store double %mul.i, double* %a.i, align 8, !store !70
  %6 = load double, double* %a.i, align 8, !store !71
  %cmp1.i = fcmp ogt double %6, -2.000000e+00, !store !72
  br i1 %cmp1.i, label %if.then2.i, label %if.end.i, !store !73

if.then2.i:                                       ; preds = %if.then.i
  %7 = load double, double* %x.addr.i, align 8, !store !74
  %8 = load double, double* %y.addr.i, align 8, !store !75
  %mul3.i = fmul double %7, %8, !store !76
  store double %mul3.i, double* %retval.i, align 8, !store !77
  br label %foo.exit, !store !78

if.end.i:                                         ; preds = %if.then.i
  br label %if.end4.i, !store !79

if.end4.i:                                        ; preds = %if.end.i, %for.body
  %9 = load double, double* %x.addr.i, align 8, !store !80
  store double %9, double* %retval.i, align 8, !store !81
  br label %foo.exit, !store !78

foo.exit:                                         ; preds = %if.end4.i, %if.then2.i
  %10 = load double, double* %retval.i, align 8, !store !82
  %11 = load double, double* %z, align 8, !store !83
  %add = fadd double %11, %10, !store !84
  store double %add, double* %z, align 8, !store !85
  br label %for.inc, !store !86

for.inc:                                          ; preds = %foo.exit
  %12 = load i32, i32* %i, align 4, !store !87
  %inc = add nsw i32 %12, 1, !store !88
  store i32 %inc, i32* %i, align 4, !store !89
  br label %for.cond, !store !56

for.end:                                          ; preds = %for.cond
  %13 = load double, double* %z, align 8, !store !90
  ret double %13, !store !91
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @sum(i32 %x) #1 !distribution !92 !store !93 !formal !92 {
entry:
  %x.addr = alloca i32, align 4, !store !23
  %result = alloca i32, align 4, !store !94
  %i = alloca i32, align 4, !store !53
  store i32 %x, i32* %x.addr, align 4, !store !26
  store i32 1, i32* %result, align 4, !store !95
  store i32 0, i32* %i, align 4, !store !96
  br label %for.cond, !store !56

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4, !store !57
  %1 = load i32, i32* %x.addr, align 4, !store !60
  %cmp = icmp slt i32 %0, %1, !store !97
  br i1 %cmp, label %for.body, label %for.end, !store !59

for.body:                                         ; preds = %for.cond
  %2 = load i32, i32* %x.addr, align 4, !store !98
  %3 = load i32, i32* %i, align 4, !store !99
  %add = add nsw i32 %2, %3, !store !100
  store i32 %add, i32* %result, align 4, !store !101
  br label %for.inc, !store !86

for.inc:                                          ; preds = %for.body
  %4 = load i32, i32* %i, align 4, !store !102
  %inc = add nsw i32 %4, 1, !store !103
  store i32 %inc, i32* %i, align 4, !store !89
  br label %for.cond, !store !56

for.end:                                          ; preds = %for.cond
  %5 = load i32, i32* %result, align 4, !store !104
  ret i32 %5, !store !105
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @foobar(i32 %a, i32 %b) #1 !distribution !106 !distribution !107 !store !108 !formal !106 !formal !107 {
entry:
  %a.addr = alloca i32, align 4, !store !109
  %b.addr = alloca i32, align 4, !store !110
  %x = alloca i32, align 4, !store !111
  %y = alloca i32, align 4, !store !112
  store i32 %a, i32* %a.addr, align 4, !store !113
  store i32 %b, i32* %b.addr, align 4, !store !114
  store i32 1, i32* %x, align 4, !store !115
  store i32 0, i32* %y, align 4, !store !116
  %0 = load i32, i32* %a.addr, align 4, !store !117
  %cmp = icmp ne i32 %0, 0, !store !118
  br i1 %cmp, label %if.then, label %if.end4, !store !11

if.then:                                          ; preds = %entry
  %1 = load i32, i32* %x, align 4, !store !119
  %add = add nsw i32 3, %1, !store !120
  store i32 %add, i32* %y, align 4, !store !121
  %2 = load i32, i32* %b.addr, align 4, !store !122
  %cmp1 = icmp eq i32 %2, 0, !store !123
  br i1 %cmp1, label %if.then2, label %if.end, !store !14

if.then2:                                         ; preds = %if.then
  %3 = load i32, i32* %a.addr, align 4, !store !124
  %4 = load i32, i32* %b.addr, align 4, !store !125
  %add3 = add nsw i32 %3, %4, !store !126
  %mul = mul nsw i32 2, %add3, !store !127
  store i32 %mul, i32* %x, align 4, !store !128
  br label %if.end, !store !129

if.end:                                           ; preds = %if.then2, %if.then
  br label %if.end4, !store !17

if.end4:                                          ; preds = %if.end, %entry
  %5 = load i32, i32* %x, align 4, !store !130
  %6 = load i32, i32* %y, align 4, !store !131
  %sub = sub nsw i32 %5, %6, !store !132
  %cmp5 = icmp ne i32 %sub, 0, !store !133
  br i1 %cmp5, label %if.then6, label %if.else, !store !134

if.then6:                                         ; preds = %if.end4
  br label %if.end7, !store !135

if.else:                                          ; preds = %if.end4
  call void @__assert_fail(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 62, i8* getelementptr inbounds ([22 x i8], [22 x i8]* @__PRETTY_FUNCTION__.foobar, i64 0, i64 0)) #3
  unreachable

if.end7:                                          ; preds = %if.then6
  ret void, !store !136
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @foobar1(i32 %a, i32 %b) #1 !distribution !137 !distribution !138 !store !108 !formal !137 !formal !138 {
entry:
  %a.addr = alloca i32, align 4, !store !109
  %b.addr = alloca i32, align 4, !store !110
  %x = alloca i32, align 4, !store !111
  %y = alloca i32, align 4, !store !112
  store i32 %a, i32* %a.addr, align 4, !store !113
  store i32 %b, i32* %b.addr, align 4, !store !114
  store i32 1, i32* %x, align 4, !store !115
  store i32 0, i32* %y, align 4, !store !116
  %0 = load i32, i32* %a.addr, align 4, !store !117
  %cmp = icmp ne i32 %0, 0, !store !118
  br i1 %cmp, label %if.then, label %if.end4, !store !11

if.then:                                          ; preds = %entry
  %1 = load i32, i32* %x, align 4, !store !119
  %add = add nsw i32 3, %1, !store !120
  store i32 %add, i32* %y, align 4, !store !121
  %2 = load i32, i32* %b.addr, align 4, !store !122
  %cmp1 = icmp eq i32 %2, 0, !store !123
  br i1 %cmp1, label %if.then2, label %if.end, !store !14

if.then2:                                         ; preds = %if.then
  %3 = load i32, i32* %a.addr, align 4, !store !124
  %4 = load i32, i32* %b.addr, align 4, !store !125
  %add3 = add nsw i32 %3, %4, !store !126
  %mul = mul nsw i32 2, %add3, !store !127
  store i32 %mul, i32* %x, align 4, !store !128
  br label %if.end, !store !129

if.end:                                           ; preds = %if.then2, %if.then
  br label %if.end4, !store !17

if.end4:                                          ; preds = %if.end, %entry
  %5 = load i32, i32* %x, align 4, !store !130
  %6 = load i32, i32* %y, align 4, !store !131
  %sub = sub nsw i32 %5, %6, !store !132
  %cmp5 = icmp ne i32 %sub, 0, !store !133
  br i1 %cmp5, label %if.then6, label %if.else, !store !134

if.then6:                                         ; preds = %if.end4
  br label %if.end7, !store !135

if.else:                                          ; preds = %if.end4
  call void @__assert_fail(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 74, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__PRETTY_FUNCTION__.foobar1, i64 0, i64 0)) #3
  unreachable

if.end7:                                          ; preds = %if.then6
  ret void, !store !136
}

attributes #0 = { alwaysinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn nounwind "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind }

!llvm.module.flags = !{!4}
!llvm.ident = !{!5}

!0 = !{!"c..str <- env(\\\220\\\22 = 120, \\\221\\\22 = 32, \\\222\\\22 = 45, \\\223\\\22 = 32, \\\224\\\22 = 121, \\\225\\\22 = 32, \\\226\\\22 = 33, \\\227\\\22 = 61, \\\228\\\22 = 32, \\\229\\\22 = 48, \\\2210\\\22 = 0)"}
!1 = !{!"c..str.1 <- env(\\\220\\\22 = 46, \\\221\\\22 = 47, \\\222\\\22 = 105, \\\223\\\22 = 110, \\\224\\\22 = 112, \\\225\\\22 = 117, \\\226\\\22 = 116, \\\227\\\22 = 47, \\\228\\\22 = 102, \\\229\\\22 = 111, \\\2210\\\22 = 111, \\\2211\\\22 = 46, \\\2212\\\22 = 99, \\\2213\\\22 = 0)"}
!2 = !{!"c.__PRETTY_FUNCTION__.foobar <- env(\\\220\\\22 = 118, \\\221\\\22 = 111, \\\222\\\22 = 105, \\\223\\\22 = 100, \\\224\\\22 = 32, \\\225\\\22 = 102, \\\226\\\22 = 111, \\\227\\\22 = 111, \\\228\\\22 = 98, \\\229\\\22 = 97, \\\2210\\\22 = 114, \\\2211\\\22 = 40, \\\2212\\\22 = 105, \\\2213\\\22 = 110, \\\2214\\\22 = 116, \\\2215\\\22 = 44, \\\2216\\\22 = 32, \\\2217\\\22 = 105, \\\2218\\\22 = 110, \\\2219\\\22 = 116, \\\2220\\\22 = 41, \\\2221\\\22 = 0)"}
!3 = !{!"c.__PRETTY_FUNCTION__.foobar1 <- env(\\\220\\\22 = 118, \\\221\\\22 = 111, \\\222\\\22 = 105, \\\223\\\22 = 100, \\\224\\\22 = 32, \\\225\\\22 = 102, \\\226\\\22 = 111, \\\227\\\22 = 111, \\\228\\\22 = 98, \\\229\\\22 = 97, \\\2210\\\22 = 114, \\\2211\\\22 = 49, \\\2212\\\22 = 40, \\\2213\\\22 = 105, \\\2214\\\22 = 110, \\\2215\\\22 = 116, \\\2216\\\22 = 44, \\\2217\\\22 = 32, \\\2218\\\22 = 105, \\\2219\\\22 = 110, \\\2220\\\22 = 116, \\\2221\\\22 = 41, \\\2222\\\22 = 0)"}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!6 = !{!"x <- Norm(mean=11, sd=1)"}
!7 = !{!"y <- Norm(mean=5, sd=1)"}
!8 = !{!"entry <- F; if.then <- F; if.then2 <- F; if.end <- F; if.end4 <- F; return <- F"}
!9 = !{!"v.add <- add(y, 6.000000e+00)"}
!10 = !{!"v.cmp <- fcmp(olt, x, v.add)"}
!11 = !{!"br(quote(if.then), quote(if.end4), v.cmp)"}
!12 = !{!"v.mul <- mul(2.000000e+00, y)"}
!13 = !{!"v.cmp1 <- fcmp(ogt, v.mul, -2.000000e+00)"}
!14 = !{!"br(quote(if.then2), quote(if.end), v.cmp1)"}
!15 = !{!"v.mul3 <- mul(x, y)"}
!16 = !{!"br(quote(return))"}
!17 = !{!"br(quote(if.end4))"}
!18 = !{!"v.retval.0 <- if (if.then2) v.mul3 else if (if.end4) x"}
!19 = !{!"path.return <<- c(path.return, ret(v.retval.0)); return <- T; if.end4 <- F; if.then2 <- F"}
!20 = !{!"x <- DiscreteDistribution(supp = 10:11)"}
!21 = !{!"y <- DiscreteDistribution(supp = 2:7)"}
!22 = !{!"p.retval <- alloca(\\\22int\\\22)"}
!23 = !{!"p.x.addr <- alloca(\\\22int\\\22)"}
!24 = !{!"p.y.addr <- alloca(\\\22int\\\22)"}
!25 = !{!"p.a <- alloca(\\\22int\\\22)"}
!26 = !{!"store(x, p.x.addr)"}
!27 = !{!"store(y, p.y.addr)"}
!28 = !{!"v.0 <- load(p.x.addr)"}
!29 = !{!"v.1 <- load(p.y.addr)"}
!30 = !{!"v.add <- add(v.1, 6)"}
!31 = !{!"v.cmp <- icmp(slt, v.0, v.add)"}
!32 = !{!"v.2 <- load(p.y.addr)"}
!33 = !{!"v.mul <- mul(2, v.2)"}
!34 = !{!"store(v.mul, p.a)"}
!35 = !{!"v.3 <- load(p.a)"}
!36 = !{!"v.cmp1 <- icmp(sge, v.3, 8)"}
!37 = !{!"v.4 <- load(p.x.addr)"}
!38 = !{!"v.5 <- load(p.y.addr)"}
!39 = !{!"v.mul3 <- mul(v.4, v.5)"}
!40 = !{!"store(v.mul3, p.retval)"}
!41 = !{!"v.6 <- load(p.x.addr)"}
!42 = !{!"store(v.6, p.retval)"}
!43 = !{!"v.7 <- load(p.retval)"}
!44 = !{!"path.return <<- c(path.return, ret(v.7)); return <- T; if.end4 <- F; if.then2 <- F"}
!45 = !{!"entry <- F; for.cond <- F; for.body <- F; if.then.i <- F; if.then2.i <- F; if.end.i <- F; if.end4.i <- F; foo.exit <- F; for.inc <- F; for.end <- F"}
!46 = !{!"p.retval.i <- alloca(\\\22float\\\22)"}
!47 = !{!"p.x.addr.i <- alloca(\\\22float\\\22)"}
!48 = !{!"p.y.addr.i <- alloca(\\\22float\\\22)"}
!49 = !{!"p.a.i <- alloca(\\\22float\\\22)"}
!50 = !{!"p.x.addr <- alloca(\\\22float\\\22)"}
!51 = !{!"p.y.addr <- alloca(\\\22float\\\22)"}
!52 = !{!"p.z <- alloca(\\\22float\\\22)"}
!53 = !{!"p.i <- alloca(\\\22int\\\22)"}
!54 = !{!"store(0.000000e+00, p.z)"}
!55 = !{!"store(1, p.i)"}
!56 = !{!"br(quote(for.cond))"}
!57 = !{!"v.0 <- load(p.i)"}
!58 = !{!"v.cmp <- icmp(slt, v.0, 3)"}
!59 = !{!"br(quote(for.body), quote(for.end), v.cmp)"}
!60 = !{!"v.1 <- load(p.x.addr)"}
!61 = !{!"store(v.1, p.x.addr.i)"}
!62 = !{!"store(v.2, p.y.addr.i)"}
!63 = !{!"v.3 <- load(p.x.addr.i)"}
!64 = !{!"v.4 <- load(p.y.addr.i)"}
!65 = !{!"v.add.i <- add(v.4, 6.000000e+00)"}
!66 = !{!"v.cmp.i <- fcmp(olt, v.3, v.add.i)"}
!67 = !{!"br(quote(if.then.i), quote(if.end4.i), v.cmp.i)"}
!68 = !{!"v.5 <- load(p.y.addr.i)"}
!69 = !{!"v.mul.i <- mul(2.000000e+00, v.5)"}
!70 = !{!"store(v.mul.i, p.a.i)"}
!71 = !{!"v.6 <- load(p.a.i)"}
!72 = !{!"v.cmp1.i <- fcmp(ogt, v.6, -2.000000e+00)"}
!73 = !{!"br(quote(if.then2.i), quote(if.end.i), v.cmp1.i)"}
!74 = !{!"v.7 <- load(p.x.addr.i)"}
!75 = !{!"v.8 <- load(p.y.addr.i)"}
!76 = !{!"v.mul3.i <- mul(v.7, v.8)"}
!77 = !{!"store(v.mul3.i, p.retval.i)"}
!78 = !{!"br(quote(foo.exit))"}
!79 = !{!"br(quote(if.end4.i))"}
!80 = !{!"v.9 <- load(p.x.addr.i)"}
!81 = !{!"store(v.9, p.retval.i)"}
!82 = !{!"v.10 <- load(p.retval.i)"}
!83 = !{!"v.11 <- load(p.z)"}
!84 = !{!"v.add <- add(v.11, v.10)"}
!85 = !{!"store(v.add, p.z)"}
!86 = !{!"br(quote(for.inc))"}
!87 = !{!"v.12 <- load(p.i)"}
!88 = !{!"v.inc <- add(v.12, 1)"}
!89 = !{!"store(v.inc, p.i)"}
!90 = !{!"v.13 <- load(p.z)"}
!91 = !{!"path.return <<- c(path.return, ret(v.13)); for.end <- T; for.cond <- F"}
!92 = !{!"x <- DiscreteDistribution(supp = 0:5)"}
!93 = !{!"entry <- F; for.cond <- F; for.body <- F; for.inc <- F; for.end <- F"}
!94 = !{!"p.result <- alloca(\\\22int\\\22)"}
!95 = !{!"store(1, p.result)"}
!96 = !{!"store(0, p.i)"}
!97 = !{!"v.cmp <- icmp(slt, v.0, v.1)"}
!98 = !{!"v.2 <- load(p.x.addr)"}
!99 = !{!"v.3 <- load(p.i)"}
!100 = !{!"v.add <- add(v.2, v.3)"}
!101 = !{!"store(v.add, p.result)"}
!102 = !{!"v.4 <- load(p.i)"}
!103 = !{!"v.inc <- add(v.4, 1)"}
!104 = !{!"v.5 <- load(p.result)"}
!105 = !{!"path.return <<- c(path.return, ret(v.5)); for.end <- T; for.cond <- F"}
!106 = !{!"a <- 1"}
!107 = !{!"b <- 0"}
!108 = !{!"entry <- F; if.then <- F; if.then2 <- F; if.end <- F; if.end4 <- F; if.then6 <- F; if.else <- F; if.end7 <- F"}
!109 = !{!"p.a.addr <- alloca(\\\22int\\\22)"}
!110 = !{!"p.b.addr <- alloca(\\\22int\\\22)"}
!111 = !{!"p.x <- alloca(\\\22int\\\22)"}
!112 = !{!"p.y <- alloca(\\\22int\\\22)"}
!113 = !{!"store(a, p.a.addr)"}
!114 = !{!"store(b, p.b.addr)"}
!115 = !{!"store(1, p.x)"}
!116 = !{!"store(0, p.y)"}
!117 = !{!"v.0 <- load(p.a.addr)"}
!118 = !{!"v.cmp <- icmp(ne, v.0, 0)"}
!119 = !{!"v.1 <- load(p.x)"}
!120 = !{!"v.add <- add(3, v.1)"}
!121 = !{!"store(v.add, p.y)"}
!122 = !{!"v.2 <- load(p.b.addr)"}
!123 = !{!"v.cmp1 <- icmp(eq, v.2, 0)"}
!124 = !{!"v.3 <- load(p.a.addr)"}
!125 = !{!"v.4 <- load(p.b.addr)"}
!126 = !{!"v.add3 <- add(v.3, v.4)"}
!127 = !{!"v.mul <- mul(2, v.add3)"}
!128 = !{!"store(v.mul, p.x)"}
!129 = !{!"br(quote(if.end))"}
!130 = !{!"v.5 <- load(p.x)"}
!131 = !{!"v.6 <- load(p.y)"}
!132 = !{!"v.sub <- sub(v.5, v.6)"}
!133 = !{!"v.cmp5 <- icmp(ne, v.sub, 0)"}
!134 = !{!"br(quote(if.then6), quote(if.else), v.cmp5)"}
!135 = !{!"br(quote(if.end7))"}
!136 = !{!"ret(\\\22void\\\22); if.end7 <- T; if.then6 <- F"}
!137 = !{!"a <- DiscreteDistribution(2)"}
!138 = !{!"b <- DiscreteDistribution(0)"}
