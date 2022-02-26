; ModuleID = './.llvm/input.ll'
source_filename = "./input/foo.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [11 x i8] c"x - y != 0\00", align 1
@.str.1 = private unnamed_addr constant [14 x i8] c"./input/foo.c\00", align 1
@__PRETTY_FUNCTION__.foobar = private unnamed_addr constant [22 x i8] c"void foobar(int, int)\00", align 1
@__PRETTY_FUNCTION__.foobar1 = private unnamed_addr constant [23 x i8] c"void foobar1(int, int)\00", align 1

; Function Attrs: alwaysinline nounwind uwtable
define dso_local double @foo(double %x, double %y) #0 !distribution !2 !distribution !3 {
entry:
  %add = fadd double %y, 6.000000e+00
  %cmp = fcmp olt double %x, %add
  br i1 %cmp, label %if.then, label %if.end4

if.then:                                          ; preds = %entry
  %mul = fmul double 2.000000e+00, %y
  %cmp1 = fcmp ogt double %mul, -2.000000e+00
  br i1 %cmp1, label %if.then2, label %if.end

if.then2:                                         ; preds = %if.then
  %mul3 = fmul double %x, %y
  br label %return

if.end:                                           ; preds = %if.then
  br label %if.end4

if.end4:                                          ; preds = %if.end, %entry
  br label %return

return:                                           ; preds = %if.end4, %if.then2
  %retval.0 = phi double [ %mul3, %if.then2 ], [ %x, %if.end4 ]
  ret double %retval.0
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @bar(i32 %x, i32 %y) #1 !distribution !4 !distribution !5 {
entry:
  %retval = alloca i32, align 4
  %x.addr = alloca i32, align 4
  %y.addr = alloca i32, align 4
  %a = alloca i32, align 4
  store i32 %x, i32* %x.addr, align 4
  store i32 %y, i32* %y.addr, align 4
  %0 = load i32, i32* %x.addr, align 4
  %1 = load i32, i32* %y.addr, align 4
  %add = add nsw i32 %1, 6
  %cmp = icmp slt i32 %0, %add
  br i1 %cmp, label %if.then, label %if.end4

if.then:                                          ; preds = %entry
  %2 = load i32, i32* %y.addr, align 4
  %mul = mul nsw i32 2, %2
  store i32 %mul, i32* %a, align 4
  %3 = load i32, i32* %a, align 4
  %cmp1 = icmp sge i32 %3, 8
  br i1 %cmp1, label %if.then2, label %if.end

if.then2:                                         ; preds = %if.then
  %4 = load i32, i32* %x.addr, align 4
  %5 = load i32, i32* %y.addr, align 4
  %mul3 = mul nsw i32 %4, %5
  store i32 %mul3, i32* %retval, align 4
  br label %return

if.end:                                           ; preds = %if.then
  br label %if.end4

if.end4:                                          ; preds = %if.end, %entry
  %6 = load i32, i32* %x.addr, align 4
  store i32 %6, i32* %retval, align 4
  br label %return

return:                                           ; preds = %if.end4, %if.then2
  %7 = load i32, i32* %retval, align 4
  ret i32 %7
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local double @baz(double %x, double %y) #1 !distribution !2 !distribution !3 {
entry:
  %retval.i = alloca double, align 8
  %x.addr.i = alloca double, align 8
  %y.addr.i = alloca double, align 8
  %a.i = alloca double, align 8
  %x.addr = alloca double, align 8
  %y.addr = alloca double, align 8
  %z = alloca double, align 8
  %i = alloca i32, align 4
  store double %x, double* %x.addr, align 8
  store double %y, double* %y.addr, align 8
  store double 0.000000e+00, double* %z, align 8
  store i32 1, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 3
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load double, double* %x.addr, align 8
  %2 = load double, double* %y.addr, align 8
  store double %1, double* %x.addr.i, align 8
  store double %2, double* %y.addr.i, align 8
  %3 = load double, double* %x.addr.i, align 8
  %4 = load double, double* %y.addr.i, align 8
  %add.i = fadd double %4, 6.000000e+00
  %cmp.i = fcmp olt double %3, %add.i
  br i1 %cmp.i, label %if.then.i, label %if.end4.i

if.then.i:                                        ; preds = %for.body
  %5 = load double, double* %y.addr.i, align 8
  %mul.i = fmul double 2.000000e+00, %5
  store double %mul.i, double* %a.i, align 8
  %6 = load double, double* %a.i, align 8
  %cmp1.i = fcmp ogt double %6, -2.000000e+00
  br i1 %cmp1.i, label %if.then2.i, label %if.end.i

if.then2.i:                                       ; preds = %if.then.i
  %7 = load double, double* %x.addr.i, align 8
  %8 = load double, double* %y.addr.i, align 8
  %mul3.i = fmul double %7, %8
  store double %mul3.i, double* %retval.i, align 8
  br label %foo.exit

if.end.i:                                         ; preds = %if.then.i
  br label %if.end4.i

if.end4.i:                                        ; preds = %if.end.i, %for.body
  %9 = load double, double* %x.addr.i, align 8
  store double %9, double* %retval.i, align 8
  br label %foo.exit

foo.exit:                                         ; preds = %if.end4.i, %if.then2.i
  %10 = load double, double* %retval.i, align 8
  %11 = load double, double* %z, align 8
  %add = fadd double %11, %10
  store double %add, double* %z, align 8
  br label %for.inc

for.inc:                                          ; preds = %foo.exit
  %12 = load i32, i32* %i, align 4
  %inc = add nsw i32 %12, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %13 = load double, double* %z, align 8
  ret double %13
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @sum(i32 %x) #1 !distribution !6 {
entry:
  %x.addr = alloca i32, align 4
  %result = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 %x, i32* %x.addr, align 4
  store i32 1, i32* %result, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %1 = load i32, i32* %x.addr, align 4
  %cmp = icmp slt i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %2 = load i32, i32* %x.addr, align 4
  %3 = load i32, i32* %i, align 4
  %add = add nsw i32 %2, %3
  store i32 %add, i32* %result, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %4 = load i32, i32* %i, align 4
  %inc = add nsw i32 %4, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %5 = load i32, i32* %result, align 4
  ret i32 %5
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @foobar(i32 %a, i32 %b) #1 !distribution !7 !distribution !8 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  store i32 %b, i32* %b.addr, align 4
  store i32 1, i32* %x, align 4
  store i32 0, i32* %y, align 4
  %0 = load i32, i32* %a.addr, align 4
  %cmp = icmp ne i32 %0, 0
  br i1 %cmp, label %if.then, label %if.end4

if.then:                                          ; preds = %entry
  %1 = load i32, i32* %x, align 4
  %add = add nsw i32 3, %1
  store i32 %add, i32* %y, align 4
  %2 = load i32, i32* %b.addr, align 4
  %cmp1 = icmp eq i32 %2, 0
  br i1 %cmp1, label %if.then2, label %if.end

if.then2:                                         ; preds = %if.then
  %3 = load i32, i32* %a.addr, align 4
  %4 = load i32, i32* %b.addr, align 4
  %add3 = add nsw i32 %3, %4
  %mul = mul nsw i32 2, %add3
  store i32 %mul, i32* %x, align 4
  br label %if.end

if.end:                                           ; preds = %if.then2, %if.then
  br label %if.end4

if.end4:                                          ; preds = %if.end, %entry
  %5 = load i32, i32* %x, align 4
  %6 = load i32, i32* %y, align 4
  %sub = sub nsw i32 %5, %6
  %cmp5 = icmp ne i32 %sub, 0
  br i1 %cmp5, label %if.then6, label %if.else

if.then6:                                         ; preds = %if.end4
  br label %if.end7

if.else:                                          ; preds = %if.end4
  call void @__assert_fail(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 62, i8* getelementptr inbounds ([22 x i8], [22 x i8]* @__PRETTY_FUNCTION__.foobar, i64 0, i64 0)) #3
  unreachable

if.end7:                                          ; preds = %if.then6
  ret void
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @foobar1(i32 %a, i32 %b) #1 !distribution !9 !distribution !10 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  store i32 %b, i32* %b.addr, align 4
  store i32 1, i32* %x, align 4
  store i32 0, i32* %y, align 4
  %0 = load i32, i32* %a.addr, align 4
  %cmp = icmp ne i32 %0, 0
  br i1 %cmp, label %if.then, label %if.end4

if.then:                                          ; preds = %entry
  %1 = load i32, i32* %x, align 4
  %add = add nsw i32 3, %1
  store i32 %add, i32* %y, align 4
  %2 = load i32, i32* %b.addr, align 4
  %cmp1 = icmp eq i32 %2, 0
  br i1 %cmp1, label %if.then2, label %if.end

if.then2:                                         ; preds = %if.then
  %3 = load i32, i32* %a.addr, align 4
  %4 = load i32, i32* %b.addr, align 4
  %add3 = add nsw i32 %3, %4
  %mul = mul nsw i32 2, %add3
  store i32 %mul, i32* %x, align 4
  br label %if.end

if.end:                                           ; preds = %if.then2, %if.then
  br label %if.end4

if.end4:                                          ; preds = %if.end, %entry
  %5 = load i32, i32* %x, align 4
  %6 = load i32, i32* %y, align 4
  %sub = sub nsw i32 %5, %6
  %cmp5 = icmp ne i32 %sub, 0
  br i1 %cmp5, label %if.then6, label %if.else

if.then6:                                         ; preds = %if.end4
  br label %if.end7

if.else:                                          ; preds = %if.end4
  call void @__assert_fail(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 74, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__PRETTY_FUNCTION__.foobar1, i64 0, i64 0)) #3
  unreachable

if.end7:                                          ; preds = %if.then6
  ret void
}

attributes #0 = { alwaysinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn nounwind "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!2 = !{!"x <- Norm(mean=11, sd=1)"}
!3 = !{!"y <- Norm(mean=5, sd=1)"}
!4 = !{!"x <- DiscreteDistribution(supp = 10:11)"}
!5 = !{!"y <- DiscreteDistribution(supp = 2:7)"}
!6 = !{!"x <- DiscreteDistribution(supp = 0:5)"}
!7 = !{!"a <- 1"}
!8 = !{!"b <- 0"}
!9 = !{!"a <- DiscreteDistribution(2)"}
!10 = !{!"b <- DiscreteDistribution(0)"}
