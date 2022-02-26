; ModuleID = 'test/r/input/foo.cost.ll'
source_filename = "./input/foo.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local double @foo(double %x, double %y) #0 !distribution !2 !distribution !3 !reliability !4 !reliability !5 !store !6 !store !7 {
entry:
  %retval = alloca double, align 8, !cost !8, !store !9
  %x.addr = alloca double, align 8, !cost !8, !store !10
  %y.addr = alloca double, align 8, !cost !8, !store !11
  %a = alloca double, align 8, !cost !8, !store !12
  store double %x, double* %x.addr, align 8, !cost !13, !store !14
  store double %y, double* %y.addr, align 8, !cost !13, !store !15
  %0 = load double, double* %x.addr, align 8, !cost !16, !store !17
  %1 = load double, double* %y.addr, align 8, !cost !16, !store !18
  %add = fadd double %1, 6.000000e+00, !cost !13, !store !19
  %cmp = fcmp olt double %0, %add, !cost !13, !store !20
  br i1 %cmp, label %if.then, label %if.end4, !cost !13, !block !21, !store !22

if.then:                                          ; preds = %entry
  %2 = load double, double* %y.addr, align 8, !cost !16, !store !23
  %mul = fmul double 2.000000e+00, %2, !cost !13, !store !24
  store double %mul, double* %a, align 8, !cost !13, !store !25
  %3 = load double, double* %a, align 8, !cost !16, !store !26
  %cmp1 = fcmp ogt double %3, -2.000000e+00, !cost !13, !store !27
  br i1 %cmp1, label %if.then2, label %if.end, !cost !13, !block !28, !store !29

if.then2:                                         ; preds = %if.then
  %4 = load double, double* %x.addr, align 8, !cost !16, !store !30
  %5 = load double, double* %y.addr, align 8, !cost !16, !store !31
  %mul3 = fmul double %4, %5, !cost !13, !store !32
  store double %mul3, double* %retval, align 8, !cost !13, !store !33
  br label %return, !cost !13, !block !34, !store !35

if.end:                                           ; preds = %if.then
  br label %if.end4, !cost !13, !block !36, !store !37

if.end4:                                          ; preds = %if.end, %entry
  %6 = load double, double* %x.addr, align 8, !cost !16, !store !38
  store double %6, double* %retval, align 8, !cost !13, !store !39
  br label %return, !cost !13, !block !40, !store !41

return:                                           ; preds = %if.end4, %if.then2
  %7 = load double, double* %retval, align 8, !cost !16, !store !42
  ret double %7, !cost !13, !block !43, !store !44
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @bar(i32 %x, i32 %y) #0 !distribution !45 !distribution !46 !reliability !4 !reliability !5 !store !47 !store !48 {
entry:
  %retval = alloca i32, align 4, !cost !8, !store !49
  %x.addr = alloca i32, align 4, !cost !8, !store !50
  %y.addr = alloca i32, align 4, !cost !8, !store !51
  %a = alloca i32, align 4, !cost !8, !store !52
  store i32 %x, i32* %x.addr, align 4, !cost !13, !store !14
  store i32 %y, i32* %y.addr, align 4, !cost !13, !store !15
  %0 = load i32, i32* %x.addr, align 4, !cost !16, !store !17
  %1 = load i32, i32* %y.addr, align 4, !cost !16, !store !18
  %add = add nsw i32 %1, 6, !cost !13, !store !53
  %cmp = icmp slt i32 %0, %add, !cost !13, !store !20
  br i1 %cmp, label %if.then, label %if.end4, !cost !13, !block !21, !store !22

if.then:                                          ; preds = %entry
  %2 = load i32, i32* %y.addr, align 4, !cost !16, !store !23
  %mul = mul nsw i32 2, %2, !cost !13, !store !54
  store i32 %mul, i32* %a, align 4, !cost !13, !store !25
  %3 = load i32, i32* %a, align 4, !cost !16, !store !26
  %cmp1 = icmp sge i32 %3, 8, !cost !13, !store !55
  br i1 %cmp1, label %if.then2, label %if.end, !cost !13, !block !28, !store !29

if.then2:                                         ; preds = %if.then
  %4 = load i32, i32* %x.addr, align 4, !cost !16, !store !30
  %5 = load i32, i32* %y.addr, align 4, !cost !16, !store !31
  %mul3 = mul nsw i32 %4, %5, !cost !13, !store !32
  store i32 %mul3, i32* %retval, align 4, !cost !13, !store !33
  br label %return, !cost !13, !block !34, !store !35

if.end:                                           ; preds = %if.then
  br label %if.end4, !cost !13, !block !36, !store !37

if.end4:                                          ; preds = %if.end, %entry
  %6 = load i32, i32* %x.addr, align 4, !cost !16, !store !38
  store i32 %6, i32* %retval, align 4, !cost !13, !store !39
  br label %return, !cost !13, !block !40, !store !41

return:                                           ; preds = %if.end4, %if.then2
  %7 = load i32, i32* %retval, align 4, !cost !16, !store !42
  ret i32 %7, !cost !13, !block !43, !store !44
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local double @baz(double %x, double %y) #0 !distribution !2 !distribution !3 !reliability !56 !reliability !57 !store !6 !store !7 {
entry:
  %x.addr = alloca double, align 8, !cost !8, !store !10
  %y.addr = alloca double, align 8, !cost !8, !store !11
  %z = alloca double, align 8, !cost !8, !store !58
  %i = alloca i32, align 4, !cost !8, !store !59
  store double %x, double* %x.addr, align 8, !cost !13, !store !14
  store double %y, double* %y.addr, align 8, !cost !13, !store !15
  store double 0.000000e+00, double* %z, align 8, !cost !13, !store !58
  store i32 1, i32* %i, align 4, !cost !13, !store !60
  br label %for.cond, !cost !13, !block !61, !store !62

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4, !cost !16, !store !63
  %cmp = icmp slt i32 %0, 3, !cost !13, !store !64
  br i1 %cmp, label %for.body, label %for.end, !cost !13, !block !40, !store !65

for.body:                                         ; preds = %for.cond
  %1 = load double, double* %x.addr, align 8, !cost !16, !store !66
  %2 = load double, double* %y.addr, align 8, !cost !16, !store !23
  %call = call double @foo(double %1, double %2), !cost !13
  %3 = load double, double* %z, align 8, !cost !16, !store !67
  %add = fadd double %3, %call, !cost !13, !store !68
  store double %add, double* %z, align 8, !cost !13, !store !69
  br label %for.inc, !cost !13, !block !70, !store !71

for.inc:                                          ; preds = %for.body
  %4 = load i32, i32* %i, align 4, !cost !16, !store !72
  %inc = add nsw i32 %4, 1, !cost !13, !store !73
  store i32 %inc, i32* %i, align 4, !cost !13, !store !74
  br label %for.cond, !cost !13, !block !75, !store !76

for.end:                                          ; preds = %for.cond
  %5 = load double, double* %z, align 8, !cost !16, !store !77
  ret double %5, !cost !13, !block !43, !store !78
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!2 = !{!"x <- Norm(mean=11, sd=1)"}
!3 = !{!"y <- Norm(mean=5, sd=1)"}
!4 = !{!"timing ;  10+ 10+ 10+ 10+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12 * DiscreteDistribution(1) 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12 * DiscreteDistribution(1)"}
!5 = !{!"energy ;  50+ 50+ 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) DiscreteDistribution(supp = 12, prob = 1) 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ DiscreteDistribution(supp = 12, prob = 1)"}
!6 = !{!"%x <- Norm(mean=11, sd=1)"}
!7 = !{!"%y <- Norm(mean=5, sd=1)"}
!8 = !{!"timing; 10;energy; 50"}
!9 = !{!"%retval <- DiscreteDistribution(0.000000e+00)"}
!10 = !{!"%x.addr <- DiscreteDistribution(0.000000e+00)"}
!11 = !{!"%y.addr <- DiscreteDistribution(0.000000e+00)"}
!12 = !{!"%a <- DiscreteDistribution(0.000000e+00)"}
!13 = !{!"timing; 12 * DiscreteDistribution(1);energy; DiscreteDistribution(supp = 12, prob = 1)"}
!14 = !{!"%x.addr <- %x"}
!15 = !{!"%y.addr <- %y"}
!16 = !{!"timing; 12;energy; 50"}
!17 = !{!"%0 <- %x.addr"}
!18 = !{!"%1 <- %y.addr"}
!19 = !{!"%add <- %1 + 6.000000e+00"}
!20 = !{!"%cmp <- %0 - %add; %cmp <- p(%cmp)(0)"}
!21 = !{!"timing ;  10+ 10+ 10+ 10+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  50+ 50+ 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!22 = !{!"%entry%if.then <- round(%cmp, 2); %entry%if.end4 <- round(1 - %cmp, 2); entry <- T"}
!23 = !{!"%2 <- %y.addr"}
!24 = !{!"%mul <- 2.000000e+00 * %2"}
!25 = !{!"%a <- %mul"}
!26 = !{!"%3 <- %a"}
!27 = !{!"%cmp1 <- %3 - -2.000000e+00; %cmp1 <- 1 - p(%cmp1)(0)"}
!28 = !{!"timing ;  12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!29 = !{!"%if.then%if.then2 <- round(%cmp1, 2); %if.then%if.end <- round(1 - %cmp1, 2); if.then <- T; entry <- F"}
!30 = !{!"%4 <- %x.addr"}
!31 = !{!"%5 <- %y.addr"}
!32 = !{!"%mul3 <- %4 * %5"}
!33 = !{!"%retval <- %mul3"}
!34 = !{!"timing ;  12+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!35 = !{!"%if.then2%return <- 1.00; if.then2 <- T; if.then <- F"}
!36 = !{!"timing ;  12 * DiscreteDistribution(1)", !"energy ;  DiscreteDistribution(supp = 12, prob = 1)"}
!37 = !{!"%if.end%if.end4 <- 1.00; if.end <- T; if.then <- F"}
!38 = !{!"%6 <- %x.addr"}
!39 = !{!"%retval <- %6"}
!40 = !{!"timing ;  12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!41 = !{!"%if.end4%return <- 1.00; if.end4 <- T; if.end <- F; entry <- F"}
!42 = !{!"%7 <- %retval"}
!43 = !{!"timing ;  12+ 12 * DiscreteDistribution(1)", !"energy ;  50+ DiscreteDistribution(supp = 12, prob = 1)"}
!44 = !{!"%ret <- %7; return <- T; if.end4 <- F; if.then2 <- F"}
!45 = !{!"x <- DiscreteDistribution(supp = 10:11)"}
!46 = !{!"y <- DiscreteDistribution(supp = 2:7)"}
!47 = !{!"%x <- DiscreteDistribution(supp = 10:11)"}
!48 = !{!"%y <- DiscreteDistribution(supp = 2:7)"}
!49 = !{!"%retval <- DiscreteDistribution(0)"}
!50 = !{!"%x.addr <- DiscreteDistribution(0)"}
!51 = !{!"%y.addr <- DiscreteDistribution(0)"}
!52 = !{!"%a <- DiscreteDistribution(0)"}
!53 = !{!"%add <- %1 + 6"}
!54 = !{!"%mul <- 2 * %2"}
!55 = !{!"%cmp1 <- %3 - 8; %cmp1 <- 1 - p(%cmp1)(0)"}
!56 = !{!"timing ;  10+ 10+ 10+ 10+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12+ 12 * DiscreteDistribution(1)+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12 * DiscreteDistribution(1)"}
!57 = !{!"energy ;  50+ 50+ 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ DiscreteDistribution(supp = 12, prob = 1)"}
!58 = !{!"%z <- DiscreteDistribution(0.000000e+00)"}
!59 = !{!"%i <- DiscreteDistribution(0)"}
!60 = !{!"%i <- DiscreteDistribution(1)"}
!61 = !{!"timing ;  10+ 10+ 10+ 10+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  50+ 50+ 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!62 = !{!"%entry%for.cond <- 1.00; entry <- T"}
!63 = !{!"%0 <- %i"}
!64 = !{!"%cmp <- %0 - 3; %cmp <- p(%cmp)(0)"}
!65 = !{!"%for.cond%for.body <- round(%cmp, 2); %for.cond%for.end <- round(1 - %cmp, 2); for.cond <- T; for.inc <- F; entry <- F"}
!66 = !{!"%1 <- %x.addr"}
!67 = !{!"%3 <- %z"}
!68 = !{!"%add <- %3 + %call"}
!69 = !{!"%z <- %add"}
!70 = !{!"timing ;  12+ 12+ 12 * DiscreteDistribution(1)+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!71 = !{!"%for.body%for.inc <- 1.00; for.body <- T; for.cond <- F"}
!72 = !{!"%4 <- %i"}
!73 = !{!"%inc <- %4 + 1"}
!74 = !{!"%i <- %inc"}
!75 = !{!"timing ;  12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!76 = !{!"%for.inc%for.cond <- 1.00; for.inc <- T; for.body <- F"}
!77 = !{!"%5 <- %z"}
!78 = !{!"%ret <- %5; for.end <- T; for.cond <- F"}
