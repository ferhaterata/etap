; ModuleID = './.llvm/input.ll'
source_filename = "./input/pointer4.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.Foo = type { i32, i32, %struct.Bar }
%struct.Bar = type { i32, i32, i32* }

@b = dso_local constant i32 5, align 4
@a = dso_local global i32* @b, align 8
@foo = dso_local global %struct.Foo { i32 0, i32 1, %struct.Bar { i32 5, i32 3, i32* @b } }, align 8

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32* @index_first() #0 {
entry:
  %0 = load i32*, i32** getelementptr inbounds (%struct.Foo, %struct.Foo* @foo, i32 0, i32 2, i32 2), align 8
  ret i32* %0
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
