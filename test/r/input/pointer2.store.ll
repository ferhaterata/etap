; ModuleID = 'test/r/input/pointer2.ll'
source_filename = "./input/pointer2.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.Foo = type { i32, i32, %struct.Bar }
%struct.Bar = type { i32, i32 }

@b = dso_local constant i32 5, align 4, !global !0
@a = dso_local global i32* @b, align 8, !global !1
@foo = dso_local global %struct.Foo { i32 0, i32 1, %struct.Bar { i32 5, i32 3 } }, align 4, !global !2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @index_first() #0 !store !5 {
entry:
  %0 = load i32*, i32** @a, align 8, !store !6
  %1 = load i32, i32* %0, align 4, !store !7
  store i32 %1, i32* getelementptr inbounds (%struct.Foo, %struct.Foo* @foo, i32 0, i32 0), align 4, !store !8
  %2 = load i32, i32* getelementptr inbounds (%struct.Foo, %struct.Foo* @foo, i32 0, i32 1), align 4, !store !9
  ret i32 %2, !store !10
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!3}
!llvm.ident = !{!4}

!0 = !{!"c.b <- 5"}
!1 = !{!"c.a <- @b"}
!2 = !{!"c.foo <- env(\\\220\\\22 = 0, \\\221\\\22 = 1, \\\222\\\22 = list(\\\220\\\22 = 5, \\\221\\\22 = 3))"}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!5 = !{!"entry <- F"}
!6 = !{!"p.0 <- c.a"}
!7 = !{!"v.1 <- p.0"}
!8 = !{!"c.foo[0] <- v.1"}
!9 = !{!"v.2 <- c.foo[1]"}
!10 = !{!"v..ret <- ret(v.2); entry <- T"}
