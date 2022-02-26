; ModuleID = 'test/r/input/andornot.ll'
source_filename = "./input/andornot.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@a = dso_local global i32 5, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @And(i32 %x, i32 %y) #0 !distribution !2 !distribution !3 !store !4 !formal !5 !formal !6 {
entry:
  %retval = alloca i32, align 4, !store !7
  %x.addr = alloca i32, align 4, !store !8
  %y.addr = alloca i32, align 4, !store !9
  store i32 %x, i32* %x.addr, align 4, !store !10
  store i32 %y, i32* %y.addr, align 4, !store !11
  %0 = load i32, i32* %x.addr, align 4, !store !12
  %cmp = icmp eq i32 %0, 0, !store !13
  br i1 %cmp, label %land.lhs.true, label %if.end, !store !14, !update !15

land.lhs.true:                                    ; preds = %entry
  %1 = load i32, i32* %y.addr, align 4, !store !16, !undo !17
  %cmp1 = icmp eq i32 %1, 3, !store !18
  br i1 %cmp1, label %if.then, label %if.end, !store !19, !update !20

if.then:                                          ; preds = %land.lhs.true
  %2 = load i32, i32* @a, align 4, !store !21, !undo !22
  %add = add nsw i32 %2, 3, !store !23
  store i32 %add, i32* %retval, align 4, !store !24
  br label %return, !store !25

if.end:                                           ; preds = %land.lhs.true, %entry
  store i32 -1, i32* %retval, align 4, !store !26, !undo !27
  br label %return, !store !25

return:                                           ; preds = %if.end, %if.then
  %3 = load i32, i32* %retval, align 4, !store !28
  ret i32 %3, !store !29
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @Or(i32 %x, i32 %y) #0 !distribution !30 !distribution !31 !store !32 !formal !33 !formal !34 {
entry:
  %retval = alloca i32, align 4, !store !7
  %x.addr = alloca i32, align 4, !store !8
  %y.addr = alloca i32, align 4, !store !9
  store i32 %x, i32* %x.addr, align 4, !store !10
  store i32 %y, i32* %y.addr, align 4, !store !11
  %0 = load i32, i32* %x.addr, align 4, !store !12
  %cmp = icmp eq i32 %0, 0, !store !13
  br i1 %cmp, label %if.then, label %lor.lhs.false, !store !35, !update !15

lor.lhs.false:                                    ; preds = %entry
  %1 = load i32, i32* %y.addr, align 4, !store !16, !undo !36
  %cmp1 = icmp eq i32 %1, 2, !store !37
  br i1 %cmp1, label %if.then, label %if.end, !store !19, !update !38

if.then:                                          ; preds = %lor.lhs.false, %entry
  store i32 0, i32* %retval, align 4, !store !39, !undo !40
  br label %return, !store !25

if.end:                                           ; preds = %lor.lhs.false
  store i32 -1, i32* %retval, align 4, !store !26, !undo !41
  br label %return, !store !25

return:                                           ; preds = %if.end, %if.then
  %2 = load i32, i32* %retval, align 4, !store !42
  ret i32 %2, !store !43
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @Not(i32 %x) #0 !distribution !44 !store !45 !formal !46 {
entry:
  %retval = alloca i32, align 4, !store !7
  %x.addr = alloca i32, align 4, !store !8
  store i32 %x, i32* %x.addr, align 4, !store !10
  %0 = load i32, i32* %x.addr, align 4, !store !12
  %cmp = icmp ne i32 %0, 0, !store !47
  br i1 %cmp, label %if.then, label %if.end, !store !48, !update !15

if.then:                                          ; preds = %entry
  store i32 0, i32* %retval, align 4, !store !39, !undo !17
  br label %return, !store !25

if.end:                                           ; preds = %entry
  store i32 -1, i32* %retval, align 4, !store !26, !undo !36
  br label %return, !store !25

return:                                           ; preds = %if.end, %if.then
  %1 = load i32, i32* %retval, align 4, !store !49
  ret i32 %1, !store !50
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local double @NotEq(double %x) #0 !distribution !51 !store !45 !formal !52 {
entry:
  %retval = alloca double, align 8, !store !53
  %x.addr = alloca double, align 8, !store !54
  store double %x, double* %x.addr, align 8, !store !10
  %0 = load double, double* %x.addr, align 8, !store !12
  %cmp = fcmp une double %0, 0.000000e+00, !store !55
  br i1 %cmp, label %if.then, label %if.end, !store !48, !update !56

if.then:                                          ; preds = %entry
  store double 0.000000e+00, double* %retval, align 8, !store !57, !undo !58
  br label %return, !store !25

if.end:                                           ; preds = %entry
  store double -1.000000e+00, double* %retval, align 8, !store !59, !undo !60
  br label %return, !store !25

return:                                           ; preds = %if.end, %if.then
  %1 = load double, double* %retval, align 8, !store !49
  ret double %1, !store !50
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!2 = !{!"x <- 0"}
!3 = !{!"y <- 2 * 1 + 1"}
!4 = !{!"entry <- FALSE; land.lhs.true <- FALSE; if.then <- FALSE; if.end <- FALSE; return <- FALSE"}
!5 = !{!"sym$\\\22x\\\22 <- 0"}
!6 = !{!"sym$\\\22y\\\22 <- 2 * 1 + 1"}
!7 = !{!"sym$\\\22retval\\\22 <- alloca(\\\22i32\\\22)"}
!8 = !{!"sym$\\\22x.addr\\\22 <- alloca(\\\22i32\\\22)"}
!9 = !{!"sym$\\\22y.addr\\\22 <- alloca(\\\22i32\\\22)"}
!10 = !{!"store(sym$\\\22x\\\22, sym$\\\22x.addr\\\22)"}
!11 = !{!"store(sym$\\\22y\\\22, sym$\\\22y.addr\\\22)"}
!12 = !{!"sym$\\\220\\\22 <- load(sym$\\\22x.addr\\\22)"}
!13 = !{!"sym$\\\22cmp\\\22 <- icmp(eq, sym$\\\220\\\22, 0)"}
!14 = !{!"br(land.lhs.true, if.end, sym$\\\22cmp\\\22)"}
!15 = !{!"{if (!is.numeric(sym$\\\220\\\22)) sym$\\\220\\\22 <- add(sym$\\\22cmp\\\22, 0)};store(sym$\\\220\\\22, sym$\\\22x.addr\\\22); "}
!16 = !{!"sym$\\\221\\\22 <- load(sym$\\\22y.addr\\\22)"}
!17 = !{!"if(entry) {sym$\\\22cmp\\\22 <- sym$\\\22cmp.true\\\22; {if (!is.numeric(sym$\\\220\\\22)) sym$\\\220\\\22 <- add(sym$\\\22cmp\\\22, 0)};store(sym$\\\220\\\22, sym$\\\22x.addr\\\22); };"}
!18 = !{!"sym$\\\22cmp1\\\22 <- icmp(eq, sym$\\\221\\\22, 3)"}
!19 = !{!"br(if.then, if.end, sym$\\\22cmp1\\\22)"}
!20 = !{!"{if (!is.numeric(sym$\\\221\\\22)) sym$\\\221\\\22 <- add(sym$\\\22cmp1\\\22, 3)};store(sym$\\\221\\\22, sym$\\\22y.addr\\\22); "}
!21 = !{!"sym$\\\222\\\22 <- load(sym$\\\22a\\\22)"}
!22 = !{!"if(land.lhs.true) {sym$\\\22cmp1\\\22 <- sym$\\\22cmp1.true\\\22; {if (!is.numeric(sym$\\\221\\\22)) sym$\\\221\\\22 <- add(sym$\\\22cmp1\\\22, 3)};store(sym$\\\221\\\22, sym$\\\22y.addr\\\22); };"}
!23 = !{!"sym$\\\22add\\\22 <- add(sym$\\\222\\\22, 3)"}
!24 = !{!"store(sym$\\\22add\\\22, sym$\\\22retval\\\22)"}
!25 = !{!"br(return)"}
!26 = !{!"store(-1, sym$\\\22retval\\\22)"}
!27 = !{!"if(entry) {sym$\\\22cmp\\\22 <- sym$\\\22cmp.false\\\22; {if (!is.numeric(sym$\\\220\\\22)) sym$\\\220\\\22 <- add(sym$\\\22cmp\\\22, 0)};store(sym$\\\220\\\22, sym$\\\22x.addr\\\22); };if(land.lhs.true) {sym$\\\22cmp1\\\22 <- sym$\\\22cmp1.false\\\22; {if (!is.numeric(sym$\\\221\\\22)) sym$\\\221\\\22 <- add(sym$\\\22cmp1\\\22, 3)};store(sym$\\\221\\\22, sym$\\\22y.addr\\\22); };"}
!28 = !{!"sym$\\\223\\\22 <- load(sym$\\\22retval\\\22)"}
!29 = !{!"path.return <<- c(path.return, ret(sym$\\\223\\\22)); return <- TRUE; if.end <- FALSE; if.then <- FALSE"}
!30 = !{!"x <- DiscreteDistribution(0)"}
!31 = !{!"y <- DiscreteDistribution(1)"}
!32 = !{!"entry <- FALSE; lor.lhs.false <- FALSE; if.then <- FALSE; if.end <- FALSE; return <- FALSE"}
!33 = !{!"sym$\\\22x\\\22 <- DiscreteDistribution(0)"}
!34 = !{!"sym$\\\22y\\\22 <- DiscreteDistribution(1)"}
!35 = !{!"br(if.then, lor.lhs.false, sym$\\\22cmp\\\22)"}
!36 = !{!"if(entry) {sym$\\\22cmp\\\22 <- sym$\\\22cmp.false\\\22; {if (!is.numeric(sym$\\\220\\\22)) sym$\\\220\\\22 <- add(sym$\\\22cmp\\\22, 0)};store(sym$\\\220\\\22, sym$\\\22x.addr\\\22); };"}
!37 = !{!"sym$\\\22cmp1\\\22 <- icmp(eq, sym$\\\221\\\22, 2)"}
!38 = !{!"{if (!is.numeric(sym$\\\221\\\22)) sym$\\\221\\\22 <- add(sym$\\\22cmp1\\\22, 2)};store(sym$\\\221\\\22, sym$\\\22y.addr\\\22); "}
!39 = !{!"store(0, sym$\\\22retval\\\22)"}
!40 = !{!"if(entry) {sym$\\\22cmp\\\22 <- sym$\\\22cmp.true\\\22; {if (!is.numeric(sym$\\\220\\\22)) sym$\\\220\\\22 <- add(sym$\\\22cmp\\\22, 0)};store(sym$\\\220\\\22, sym$\\\22x.addr\\\22); };if(lor.lhs.false) {sym$\\\22cmp1\\\22 <- sym$\\\22cmp1.true\\\22; {if (!is.numeric(sym$\\\221\\\22)) sym$\\\221\\\22 <- add(sym$\\\22cmp1\\\22, 2)};store(sym$\\\221\\\22, sym$\\\22y.addr\\\22); };"}
!41 = !{!"if(lor.lhs.false) {sym$\\\22cmp1\\\22 <- sym$\\\22cmp1.false\\\22; {if (!is.numeric(sym$\\\221\\\22)) sym$\\\221\\\22 <- add(sym$\\\22cmp1\\\22, 2)};store(sym$\\\221\\\22, sym$\\\22y.addr\\\22); };"}
!42 = !{!"sym$\\\222\\\22 <- load(sym$\\\22retval\\\22)"}
!43 = !{!"path.return <<- c(path.return, ret(sym$\\\222\\\22)); return <- TRUE; if.end <- FALSE; if.then <- FALSE"}
!44 = !{!"x <- DiscreteDistribution(supp = c(1, 0), prob = c(0.4, 0.6))"}
!45 = !{!"entry <- FALSE; if.then <- FALSE; if.end <- FALSE; return <- FALSE"}
!46 = !{!"sym$\\\22x\\\22 <- DiscreteDistribution(supp = c(1, 0), prob = c(0.4, 0.6))"}
!47 = !{!"sym$\\\22cmp\\\22 <- icmp(ne, sym$\\\220\\\22, 0)"}
!48 = !{!"br(if.then, if.end, sym$\\\22cmp\\\22)"}
!49 = !{!"sym$\\\221\\\22 <- load(sym$\\\22retval\\\22)"}
!50 = !{!"path.return <<- c(path.return, ret(sym$\\\221\\\22)); return <- TRUE; if.end <- FALSE; if.then <- FALSE"}
!51 = !{!"x <- Unif(Min=0, Max=1)"}
!52 = !{!"sym$\\\22x\\\22 <- Unif(Min=0, Max=1)"}
!53 = !{!"sym$\\\22retval\\\22 <- alloca(\\\22double\\\22)"}
!54 = !{!"sym$\\\22x.addr\\\22 <- alloca(\\\22double\\\22)"}
!55 = !{!"sym$\\\22cmp\\\22 <- fcmp(une, sym$\\\220\\\22, 0.000000e+00)"}
!56 = !{!"{if (!is.numeric(sym$\\\220\\\22)) sym$\\\220\\\22 <- add(sym$\\\22cmp\\\22, 0.000000e+00)};store(sym$\\\220\\\22, sym$\\\22x.addr\\\22); "}
!57 = !{!"store(0.000000e+00, sym$\\\22retval\\\22)"}
!58 = !{!"if(entry) {sym$\\\22cmp\\\22 <- sym$\\\22cmp.true\\\22; {if (!is.numeric(sym$\\\220\\\22)) sym$\\\220\\\22 <- add(sym$\\\22cmp\\\22, 0.000000e+00)};store(sym$\\\220\\\22, sym$\\\22x.addr\\\22); };"}
!59 = !{!"store(-1.000000e+00, sym$\\\22retval\\\22)"}
!60 = !{!"if(entry) {sym$\\\22cmp\\\22 <- sym$\\\22cmp.false\\\22; {if (!is.numeric(sym$\\\220\\\22)) sym$\\\220\\\22 <- add(sym$\\\22cmp\\\22, 0.000000e+00)};store(sym$\\\220\\\22, sym$\\\22x.addr\\\22); };"}
