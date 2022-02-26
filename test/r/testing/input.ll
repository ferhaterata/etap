; ModuleID = './.llvm/input.ll'
source_filename = "./input/conditional3.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @checkpoint() #0 !reliability !2 !reliability !3 !intermittent !4 !intermittent !5 {
entry:
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @conditional3(i32 %n) #0 !distribution !6 { ; double %E
entry: ; E
  %retval = alloca i32, align 4  ; cost.E, cost.T
  %n.addr = alloca i32, align 4  ; cost
  %x = alloca i32, align 4
  %xp = alloca i32*, align 8
  store i32 %n, i32* %n.addr, align 4
  %0 = load i32, i32* %n.addr, align 4
  store i32 %0, i32* %x, align 4
  store i32* %x, i32** %xp, align 8
  br label %checkpoint1

checkpoint1: ; preds = %entry
  call void @checkpoint() ; E <- max.E
  %1 = load i32, i32* %n.addr, align 4
  %cmp = icmp sgt i32 %1, 1
  br i1 %cmp, label %failure1, label %failure2

failure1:
  %failure1.cmp = icmp slt i32 %E.T, %cum.energy.cost
  br i1 %failure1.cmp, label %if.then, label %checkpoint1

failure2:
  %failure2.cmp = icmp slt i32 %E.T, %cum.energy.cost
  br i1 %failure2.cmp, label %if.end3, label %checkpoint1

if.then:                                          ; preds = %entry
  %2 = load i32, i32* %n.addr, align 4
  %cmp1 = icmp sgt i32 %2, 2
  br i1 %cmp1, label %if.then2, label %if.end

if.then2:                                         ; preds = %if.then
  %3 = load i32, i32* %n.addr, align 4
  store i32 %3, i32* %retval, align 4
  br label %return

if.end:                                           ; preds = %if.then
  br label %if.end3

if.end3:                                          ; preds = %if.end, %entry
  call void @checkpoint()
  %4 = load i32*, i32** %xp, align 8
  %5 = load i32, i32* %4, align 4
  store i32 %5, i32* %retval, align 4
  br label %return

return:                                           ; preds = %if.end3, %if.then2
  %6 = load i32, i32* %retval, align 4
  ret i32 %6
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!2 = !{!"Reliability Energy Cost Fixed ; 10"}
!3 = !{!"Reliability Timing Cost Fixed ; 15"}
!4 = !{!"Intermittent Capacitor 100,2000"}
!5 = !{!"Intermittent Checkpoint"}
!6 = !{!"n <- DiscreteDistribution(supp=1:4)"}
