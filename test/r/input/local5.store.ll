; ModuleID = 'test/r/input/local5.ll'
source_filename = "./input/local5.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @pointer() #0 !store !2 {
entry:
  %b = alloca i32, align 4, !store !3
  %a = alloca i32*, align 8, !store !4
  store i32 5, i32* %b, align 4, !store !5
  store i32* %b, i32** %a, align 8, !store !6
  %0 = load i32*, i32** %a, align 8, !store !7
  %1 = load i32, i32* %0, align 4, !store !8
  ret i32 %1, !store !9
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!2 = !{!"entry <- F"}
!3 = !{!"p.b <- alloca(\22int\22)"}
!4 = !{!"p.a <- alloca(\22int*\22)"}
!5 = !{!"store(5, p.b)"}
!6 = !{!"store(p.b, p.a)"}
!7 = !{!"p.0 <- load(p.a)"}
!8 = !{!"v.1 <- load(p.0)"}
!9 = !{!".ret <- ret(v.1); entry <- T"}
