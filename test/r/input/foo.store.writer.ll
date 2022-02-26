; ModuleID = 'test/r/input/foo.store.ll'
source_filename = "./input/foo.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local double @foo(double %x, double %y) #0 !distribution !2 !distribution !3 !store !4 !store !5 {
entry:
  %retval = alloca double, align 8, !store !6
  %x.addr = alloca double, align 8, !store !7
  %y.addr = alloca double, align 8, !store !8
  %a = alloca double, align 8, !store !9
  store double %x, double* %x.addr, align 8, !store !10
  store double %y, double* %y.addr, align 8, !store !11
  %0 = load double, double* %x.addr, align 8, !store !12
  %1 = load double, double* %y.addr, align 8, !store !13
  %add = fadd double %1, 6.000000e+00, !store !14
  %cmp = fcmp olt double %0, %add, !store !15
  br i1 %cmp, label %if.then, label %if.end4, !store !16

if.then:                                          ; preds = %entry
  %2 = load double, double* %y.addr, align 8, !store !17
  %mul = fmul double 2.000000e+00, %2, !store !18
  store double %mul, double* %a, align 8, !store !19
  %3 = load double, double* %a, align 8, !store !20
  %cmp1 = fcmp ogt double %3, -2.000000e+00, !store !21
  br i1 %cmp1, label %if.then2, label %if.end, !store !22

if.then2:                                         ; preds = %if.then
  %4 = load double, double* %x.addr, align 8, !store !23
  %5 = load double, double* %y.addr, align 8, !store !24
  %mul3 = fmul double %4, %5, !store !25
  store double %mul3, double* %retval, align 8, !store !26
  br label %return, !store !27

if.end:                                           ; preds = %if.then
  br label %if.end4, !store !28

if.end4:                                          ; preds = %if.end, %entry
  %6 = load double, double* %x.addr, align 8, !store !29
  store double %6, double* %retval, align 8, !store !30
  br label %return, !store !31

return:                                           ; preds = %if.end4, %if.then2
  %7 = load double, double* %retval, align 8, !store !32
  ret double %7, !store !33
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @bar(i32 %x, i32 %y) #0 !distribution !34 !distribution !35 !store !36 !store !37 {
entry:
  %retval = alloca i32, align 4, !store !38
  %x.addr = alloca i32, align 4, !store !39
  %y.addr = alloca i32, align 4, !store !40
  %a = alloca i32, align 4, !store !41
  store i32 %x, i32* %x.addr, align 4, !store !10
  store i32 %y, i32* %y.addr, align 4, !store !11
  %0 = load i32, i32* %x.addr, align 4, !store !12
  %1 = load i32, i32* %y.addr, align 4, !store !13
  %add = add nsw i32 %1, 6, !store !42
  %cmp = icmp slt i32 %0, %add, !store !15
  br i1 %cmp, label %if.then, label %if.end4, !store !16

if.then:                                          ; preds = %entry
  %2 = load i32, i32* %y.addr, align 4, !store !17
  %mul = mul nsw i32 2, %2, !store !43
  store i32 %mul, i32* %a, align 4, !store !19
  %3 = load i32, i32* %a, align 4, !store !20
  %cmp1 = icmp sge i32 %3, 8, !store !44
  br i1 %cmp1, label %if.then2, label %if.end, !store !22

if.then2:                                         ; preds = %if.then
  %4 = load i32, i32* %x.addr, align 4, !store !23
  %5 = load i32, i32* %y.addr, align 4, !store !24
  %mul3 = mul nsw i32 %4, %5, !store !25
  store i32 %mul3, i32* %retval, align 4, !store !26
  br label %return, !store !27

if.end:                                           ; preds = %if.then
  br label %if.end4, !store !28

if.end4:                                          ; preds = %if.end, %entry
  %6 = load i32, i32* %x.addr, align 4, !store !29
  store i32 %6, i32* %retval, align 4, !store !30
  br label %return, !store !31

return:                                           ; preds = %if.end4, %if.then2
  %7 = load i32, i32* %retval, align 4, !store !32
  ret i32 %7, !store !33
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local double @baz(double %x, double %y) #0 !distribution !2 !distribution !3 !store !4 !store !5 {
entry:
  %x.addr = alloca double, align 8, !store !7
  %y.addr = alloca double, align 8, !store !8
  %z = alloca double, align 8, !store !45
  %i = alloca i32, align 4, !store !46
  store double %x, double* %x.addr, align 8, !store !10
  store double %y, double* %y.addr, align 8, !store !11
  store double 0.000000e+00, double* %z, align 8, !store !45
  store i32 1, i32* %i, align 4, !store !47
  br label %for.cond, !store !48

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4, !store !49
  %cmp = icmp slt i32 %0, 3, !store !50
  br i1 %cmp, label %for.body, label %for.end, !store !51

for.body:                                         ; preds = %for.cond
  %1 = load double, double* %x.addr, align 8, !store !52
  %2 = load double, double* %y.addr, align 8, !store !17
  %call = call double @foo(double %1, double %2)
  %3 = load double, double* %z, align 8, !store !53
  %add = fadd double %3, %call, !store !54
  store double %add, double* %z, align 8, !store !55
  br label %for.inc, !store !56

for.inc:                                          ; preds = %for.body
  %4 = load i32, i32* %i, align 4, !store !57
  %inc = add nsw i32 %4, 1, !store !58
  store i32 %inc, i32* %i, align 4, !store !59
  br label %for.cond, !store !60

for.end:                                          ; preds = %for.cond
  %5 = load double, double* %z, align 8, !store !61
  ret double %5, !store !62
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!2 = !{!"x <- Norm(mean=11, sd=1)"}
!3 = !{!"y <- Norm(mean=5, sd=1)"}
!4 = !{!"%x <- Norm(mean=11, sd=1)"}
!5 = !{!"%y <- Norm(mean=5, sd=1)"}
!6 = !{!"%retval <- DiscreteDistribution(0.000000e+00)"}
!7 = !{!"%x.addr <- DiscreteDistribution(0.000000e+00)"}
!8 = !{!"%y.addr <- DiscreteDistribution(0.000000e+00)"}
!9 = !{!"%a <- DiscreteDistribution(0.000000e+00)"}
!10 = !{!"%x.addr <- %x"}
!11 = !{!"%y.addr <- %y"}
!12 = !{!"%0 <- %x.addr"}
!13 = !{!"%1 <- %y.addr"}
!14 = !{!"%add <- %1 + 6.000000e+00"}
!15 = !{!"%cmp <- %0 - %add; %cmp <- p(%cmp)(0)"}
!16 = !{!"%entry%if.then <- round(%cmp, 2); %entry%if.end4 <- round(1 - %cmp, 2); entry <- T"}
!17 = !{!"%2 <- %y.addr"}
!18 = !{!"%mul <- 2.000000e+00 * %2"}
!19 = !{!"%a <- %mul"}
!20 = !{!"%3 <- %a"}
!21 = !{!"%cmp1 <- %3 - -2.000000e+00; %cmp1 <- 1 - p(%cmp1)(0)"}
!22 = !{!"%if.then%if.then2 <- round(%cmp1, 2); %if.then%if.end <- round(1 - %cmp1, 2); if.then <- T; entry <- F"}
!23 = !{!"%4 <- %x.addr"}
!24 = !{!"%5 <- %y.addr"}
!25 = !{!"%mul3 <- %4 * %5"}
!26 = !{!"%retval <- %mul3"}
!27 = !{!"%if.then2%return <- 1.00; if.then2 <- T; if.then <- F"}
!28 = !{!"%if.end%if.end4 <- 1.00; if.end <- T; if.then <- F"}
!29 = !{!"%6 <- %x.addr"}
!30 = !{!"%retval <- %6"}
!31 = !{!"%if.end4%return <- 1.00; if.end4 <- T; if.end <- F; entry <- F"}
!32 = !{!"%7 <- %retval"}
!33 = !{!"%ret <- %7; return <- T; if.end4 <- F; if.then2 <- F"}
!34 = !{!"x <- DiscreteDistribution(supp = 10:11)"}
!35 = !{!"y <- DiscreteDistribution(supp = 2:7)"}
!36 = !{!"%x <- DiscreteDistribution(supp = 10:11)"}
!37 = !{!"%y <- DiscreteDistribution(supp = 2:7)"}
!38 = !{!"%retval <- DiscreteDistribution(0)"}
!39 = !{!"%x.addr <- DiscreteDistribution(0)"}
!40 = !{!"%y.addr <- DiscreteDistribution(0)"}
!41 = !{!"%a <- DiscreteDistribution(0)"}
!42 = !{!"%add <- %1 + 6"}
!43 = !{!"%mul <- 2 * %2"}
!44 = !{!"%cmp1 <- %3 - 8; %cmp1 <- 1 - p(%cmp1)(0)"}
!45 = !{!"%z <- DiscreteDistribution(0.000000e+00)"}
!46 = !{!"%i <- DiscreteDistribution(0)"}
!47 = !{!"%i <- DiscreteDistribution(1)"}
!48 = !{!"%entry%for.cond <- 1.00; entry <- T"}
!49 = !{!"%0 <- %i"}
!50 = !{!"%cmp <- %0 - 3; %cmp <- p(%cmp)(0)"}
!51 = !{!"%for.cond%for.body <- round(%cmp, 2); %for.cond%for.end <- round(1 - %cmp, 2); for.cond <- T; for.inc <- F; entry <- F"}
!52 = !{!"%1 <- %x.addr"}
!53 = !{!"%3 <- %z"}
!54 = !{!"%add <- %3 + %call"}
!55 = !{!"%z <- %add"}
!56 = !{!"%for.body%for.inc <- 1.00; for.body <- T; for.cond <- F"}
!57 = !{!"%4 <- %i"}
!58 = !{!"%inc <- %4 + 1"}
!59 = !{!"%i <- %inc"}
!60 = !{!"%for.inc%for.cond <- 1.00; for.inc <- T; for.body <- F"}
!61 = !{!"%5 <- %z"}
!62 = !{!"%ret <- %5; for.end <- T; for.cond <- F"}
