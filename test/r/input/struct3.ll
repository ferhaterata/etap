; ModuleID = './.llvm/input.ll'
source_filename = "./input/struct3.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.Foo = type { i32, i32, i32 }

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @index_i(i32 %i) #0 {
entry:
  %i.addr = alloca i32, align 4
  %foo = alloca [3 x %struct.Foo], align 16
  store i32 %i, i32* %i.addr, align 4
  %0 = load i32, i32* %i.addr, align 4
  %idxprom = sext i32 %0 to i64
  %arrayidx = getelementptr inbounds [3 x %struct.Foo], [3 x %struct.Foo]* %foo, i64 0, i64 %idxprom
  %b = getelementptr inbounds %struct.Foo, %struct.Foo* %arrayidx, i32 0, i32 1
  store i32 4, i32* %b, align 4
  %1 = load i32, i32* %i.addr, align 4
  %idxprom1 = sext i32 %1 to i64
  %arrayidx2 = getelementptr inbounds [3 x %struct.Foo], [3 x %struct.Foo]* %foo, i64 0, i64 %idxprom1
  %b3 = getelementptr inbounds %struct.Foo, %struct.Foo* %arrayidx2, i32 0, i32 1
  %2 = load i32, i32* %b3, align 4
  ret i32 %2
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
