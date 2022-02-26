; ModuleID = './.llvm/input.ll'
source_filename = "./input/swap.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@x = dso_local global i32 3, align 4
@y = dso_local global i32 5, align 4

; Function Attrs: alwaysinline nounwind uwtable
define dso_local void @swap(i32* %xp, i32* %yp) #0 !distribution !2 !distribution !3 {
entry:
  %0 = load i32, i32* %xp, align 4
  %1 = load i32, i32* %yp, align 4
  store i32 %1, i32* %xp, align 4
  store i32 %0, i32* %yp, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #1 {
entry:
  %xp.addr.i = alloca i32*, align 8
  %yp.addr.i = alloca i32*, align 8
  %temp.i = alloca i32, align 4
  %retval = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  store i32* @x, i32** %xp.addr.i, align 8
  store i32* @y, i32** %yp.addr.i, align 8
  %0 = load i32*, i32** %xp.addr.i, align 8
  %1 = load i32, i32* %0, align 4
  store i32 %1, i32* %temp.i, align 4
  %2 = load i32*, i32** %yp.addr.i, align 8
  %3 = load i32, i32* %2, align 4
  %4 = load i32*, i32** %xp.addr.i, align 8
  store i32 %3, i32* %4, align 4
  %5 = load i32, i32* %temp.i, align 4
  %6 = load i32*, i32** %yp.addr.i, align 8
  store i32 %5, i32* %6, align 4
  %7 = load i32, i32* @x, align 4
  ret i32 %7
}

attributes #0 = { alwaysinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!2 = !{!"xp <- 8"}
!3 = !{!"yp <- 1"}
