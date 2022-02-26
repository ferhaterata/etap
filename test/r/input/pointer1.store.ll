; ModuleID = 'test/r/input/pointer1.ll'
source_filename = "./input/pointer1.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@b = dso_local global i32 5, align 4, !global !0
@a = dso_local global i32* @b, align 8, !global !1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @index_first() #0 !store !4 {
entry:
  %0 = load i32*, i32** @a, align 8, !store !5
  %1 = load i32, i32* %0, align 4, !store !6
  ret i32 %1, !store !7
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!2}
!llvm.ident = !{!3}

!0 = !{!"\22sym$\\\22@b\\\22 <- galloc(\\\22i32\\\22, 5)\22"}
!1 = !{!"\22sym$\\\22@a\\\22 <- galloc(\\\22i32*\\\22, sym$\\\22@b\\\22)\22"}
!2 = !{i32 1, !"wchar_size", i32 4}
!3 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!4 = !{!"entry <- FALSE"}
!5 = !{!"p.0 <- load(ptr(c.a))"}
!6 = !{!"v.1 <- load(p.0)"}
!7 = !{!"path.return <<- c(path.return, ret(v.1)); entry <- TRUE"}
