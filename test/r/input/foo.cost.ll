; ModuleID = './.llvm/inst-conf.ll'
source_filename = "./input/foo.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local double @foo(double %x, double %y) #0 !distribution !2 !distribution !3 !reliability !4 !reliability !5 {
entry:
  %retval = alloca double, align 8, !cost !6
  %x.addr = alloca double, align 8, !cost !6
  %y.addr = alloca double, align 8, !cost !6
  %a = alloca double, align 8, !cost !6
  store double %x, double* %x.addr, align 8, !cost !7
  store double %y, double* %y.addr, align 8, !cost !7
  %0 = load double, double* %x.addr, align 8, !cost !8
  %1 = load double, double* %y.addr, align 8, !cost !8
  %add = fadd double %1, 6.000000e+00, !cost !7
  %cmp = fcmp olt double %0, %add, !cost !7
  br i1 %cmp, label %if.then, label %if.end4, !cost !7, !block !9

if.then:                                          ; preds = %entry
  %2 = load double, double* %y.addr, align 8, !cost !8
  %mul = fmul double 2.000000e+00, %2, !cost !7
  store double %mul, double* %a, align 8, !cost !7
  %3 = load double, double* %a, align 8, !cost !8
  %cmp1 = fcmp ogt double %3, -2.000000e+00, !cost !7
  br i1 %cmp1, label %if.then2, label %if.end, !cost !7, !block !10

if.then2:                                         ; preds = %if.then
  %4 = load double, double* %x.addr, align 8, !cost !8
  %5 = load double, double* %y.addr, align 8, !cost !8
  %mul3 = fmul double %4, %5, !cost !7
  store double %mul3, double* %retval, align 8, !cost !7
  br label %return, !cost !7, !block !11

if.end:                                           ; preds = %if.then
  br label %if.end4, !cost !7, !block !12

if.end4:                                          ; preds = %if.end, %entry
  %6 = load double, double* %x.addr, align 8, !cost !8
  store double %6, double* %retval, align 8, !cost !7
  br label %return, !cost !7, !block !13

return:                                           ; preds = %if.end4, %if.then2
  %7 = load double, double* %retval, align 8, !cost !8
  ret double %7, !cost !7, !block !14
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @bar(i32 %x, i32 %y) #0 !distribution !15 !distribution !16 !reliability !4 !reliability !5 {
entry:
  %retval = alloca i32, align 4, !cost !6
  %x.addr = alloca i32, align 4, !cost !6
  %y.addr = alloca i32, align 4, !cost !6
  %a = alloca i32, align 4, !cost !6
  store i32 %x, i32* %x.addr, align 4, !cost !7
  store i32 %y, i32* %y.addr, align 4, !cost !7
  %0 = load i32, i32* %x.addr, align 4, !cost !8
  %1 = load i32, i32* %y.addr, align 4, !cost !8
  %add = add nsw i32 %1, 6, !cost !7
  %cmp = icmp slt i32 %0, %add, !cost !7
  br i1 %cmp, label %if.then, label %if.end4, !cost !7, !block !9

if.then:                                          ; preds = %entry
  %2 = load i32, i32* %y.addr, align 4, !cost !8
  %mul = mul nsw i32 2, %2, !cost !7
  store i32 %mul, i32* %a, align 4, !cost !7
  %3 = load i32, i32* %a, align 4, !cost !8
  %cmp1 = icmp sge i32 %3, 8, !cost !7
  br i1 %cmp1, label %if.then2, label %if.end, !cost !7, !block !10

if.then2:                                         ; preds = %if.then
  %4 = load i32, i32* %x.addr, align 4, !cost !8
  %5 = load i32, i32* %y.addr, align 4, !cost !8
  %mul3 = mul nsw i32 %4, %5, !cost !7
  store i32 %mul3, i32* %retval, align 4, !cost !7
  br label %return, !cost !7, !block !11

if.end:                                           ; preds = %if.then
  br label %if.end4, !cost !7, !block !12

if.end4:                                          ; preds = %if.end, %entry
  %6 = load i32, i32* %x.addr, align 4, !cost !8
  store i32 %6, i32* %retval, align 4, !cost !7
  br label %return, !cost !7, !block !13

return:                                           ; preds = %if.end4, %if.then2
  %7 = load i32, i32* %retval, align 4, !cost !8
  ret i32 %7, !cost !7, !block !14
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local double @baz(double %x, double %y) #0 !distribution !2 !distribution !3 !reliability !17 !reliability !18 {
entry:
  %x.addr = alloca double, align 8, !cost !6
  %y.addr = alloca double, align 8, !cost !6
  %z = alloca double, align 8, !cost !6
  %i = alloca i32, align 4, !cost !6
  store double %x, double* %x.addr, align 8, !cost !7
  store double %y, double* %y.addr, align 8, !cost !7
  store double 0.000000e+00, double* %z, align 8, !cost !7
  store i32 1, i32* %i, align 4, !cost !7
  br label %for.cond, !cost !7, !block !19

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4, !cost !8
  %cmp = icmp slt i32 %0, 3, !cost !7
  br i1 %cmp, label %for.body, label %for.end, !cost !7, !block !13

for.body:                                         ; preds = %for.cond
  %1 = load double, double* %x.addr, align 8, !cost !8
  %2 = load double, double* %y.addr, align 8, !cost !8
  %call = call double @foo(double %1, double %2), !cost !7
  %3 = load double, double* %z, align 8, !cost !8
  %add = fadd double %3, %call, !cost !7
  store double %add, double* %z, align 8, !cost !7
  br label %for.inc, !cost !7, !block !20

for.inc:                                          ; preds = %for.body
  %4 = load i32, i32* %i, align 4, !cost !8
  %inc = add nsw i32 %4, 1, !cost !7
  store i32 %inc, i32* %i, align 4, !cost !7
  br label %for.cond, !cost !7, !block !21

for.end:                                          ; preds = %for.cond
  %5 = load double, double* %z, align 8, !cost !8
  ret double %5, !cost !7, !block !14
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
!6 = !{!"timing; 10;energy; 50"}
!7 = !{!"timing; 12 * DiscreteDistribution(1);energy; DiscreteDistribution(supp = 12, prob = 1)"}
!8 = !{!"timing; 12;energy; 50"}
!9 = !{!"timing ;  10+ 10+ 10+ 10+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  50+ 50+ 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!10 = !{!"timing ;  12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!11 = !{!"timing ;  12+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!12 = !{!"timing ;  12 * DiscreteDistribution(1)", !"energy ;  DiscreteDistribution(supp = 12, prob = 1)"}
!13 = !{!"timing ;  12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!14 = !{!"timing ;  12+ 12 * DiscreteDistribution(1)", !"energy ;  50+ DiscreteDistribution(supp = 12, prob = 1)"}
!15 = !{!"x <- DiscreteDistribution(supp = 10:11)"}
!16 = !{!"y <- DiscreteDistribution(supp = 2:7)"}
!17 = !{!"timing ;  10+ 10+ 10+ 10+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12+ 12 * DiscreteDistribution(1)+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12 * DiscreteDistribution(1)"}
!18 = !{!"energy ;  50+ 50+ 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ DiscreteDistribution(supp = 12, prob = 1)"}
!19 = !{!"timing ;  10+ 10+ 10+ 10+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  50+ 50+ 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!20 = !{!"timing ;  12+ 12+ 12 * DiscreteDistribution(1)+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!21 = !{!"timing ;  12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
