; ModuleID = 'test/r/input/conditional.ll'
source_filename = "./input/conditional.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @conditional(i32 %n) #0 !distribution !2 !store !3 !formal !2 {
entry:
  %retval = alloca i32, align 4, !store !4
  %n.addr = alloca i32, align 4, !store !5
  store i32 %n, i32* %n.addr, align 4, !store !6
  %0 = load i32, i32* %n.addr, align 4, !store !7
  %cmp = icmp sgt i32 %0, 1, !store !8
  br i1 %cmp, label %if.then, label %if.end, !store !9

if.then:                                          ; preds = %entry
  %1 = load i32, i32* %n.addr, align 4, !store !10
  store i32 %1, i32* %retval, align 4, !store !11
  br label %return, !store !12

if.end:                                           ; preds = %entry
  %2 = load i32, i32* %n.addr, align 4, !store !13
  store i32 %2, i32* %retval, align 4, !store !14
  br label %return, !store !12

return:                                           ; preds = %if.end, %if.then
  %3 = load i32, i32* %retval, align 4, !store !15
  ret i32 %3, !store !16
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!2 = !{!"n <- DiscreteDistribution(supp=1:4)"}
!3 = !{!"entry <- F; if.then <- F; if.end <- F; return <- F"}
!4 = !{!"p.retval <- alloca(\\\22int\\\22)"}
!5 = !{!"p.n.addr <- alloca(\\\22int\\\22)"}
!6 = !{!"store(n, p.n.addr)"}
!7 = !{!"v.0 <- load(p.n.addr)"}
!8 = !{!"v.cmp <- icmp(sgt, v.0, 1)"}
!9 = !{!"br(quote(if.then), quote(if.end), v.cmp)"}
!10 = !{!"v.1 <- load(p.n.addr)"}
!11 = !{!"store(v.1, p.retval)"}
!12 = !{!"br(quote(return))"}
!13 = !{!"v.2 <- load(p.n.addr)"}
!14 = !{!"store(v.2, p.retval)"}
!15 = !{!"v.3 <- load(p.retval)"}
!16 = !{!"path.return <<- c(path.return, ret(v.3)); return <- T; if.end <- F; if.then <- F"}
