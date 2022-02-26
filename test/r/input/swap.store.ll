; ModuleID = 'test/r/input/swap.ll'
source_filename = "./input/swap.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@x = dso_local global i32 3, align 4, !global !0
@y = dso_local global i32 5, align 4, !global !1

; Function Attrs: alwaysinline nounwind uwtable
define dso_local void @swap(i32* %xp, i32* %yp) #0 !distribution !4 !distribution !5 !store !6 !formal !4 !formal !5 {
entry:
  %0 = load i32, i32* %xp, align 4, !store !7
  %1 = load i32, i32* %yp, align 4, !store !8
  store i32 %1, i32* %xp, align 4, !store !9
  store i32 %0, i32* %yp, align 4, !store !10
  ret void, !store !11
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #1 !store !6 {
entry:
  %xp.addr.i = alloca i32*, align 8, !store !12
  %yp.addr.i = alloca i32*, align 8, !store !13
  %temp.i = alloca i32, align 4, !store !14
  %retval = alloca i32, align 4, !store !15
  store i32 0, i32* %retval, align 4, !store !16
  store i32* @x, i32** %xp.addr.i, align 8, !store !17
  store i32* @y, i32** %yp.addr.i, align 8, !store !18
  %0 = load i32*, i32** %xp.addr.i, align 8, !store !19
  %1 = load i32, i32* %0, align 4, !store !20
  store i32 %1, i32* %temp.i, align 4, !store !21
  %2 = load i32*, i32** %yp.addr.i, align 8, !store !22
  %3 = load i32, i32* %2, align 4, !store !23
  %4 = load i32*, i32** %xp.addr.i, align 8, !store !24
  store i32 %3, i32* %4, align 4, !store !25
  %5 = load i32, i32* %temp.i, align 4, !store !26
  %6 = load i32*, i32** %yp.addr.i, align 8, !store !27
  store i32 %5, i32* %6, align 4, !store !28
  %7 = load i32, i32* @x, align 4, !store !29
  ret i32 %7, !store !30
}

attributes #0 = { alwaysinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!2}
!llvm.ident = !{!3}

!0 = !{!"c.x <- 3"}
!1 = !{!"c.y <- 5"}
!2 = !{i32 1, !"wchar_size", i32 4}
!3 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!4 = !{!"xp <- 8"}
!5 = !{!"yp <- 1"}
!6 = !{!"entry <- F"}
!7 = !{!"v.0 <- load(ptr(xp))"}
!8 = !{!"v.1 <- load(ptr(yp))"}
!9 = !{!"store(v.1, ptr(xp))"}
!10 = !{!"store(v.0, ptr(yp))"}
!11 = !{!".ret <- ret(NA); entry <- T"}
!12 = !{!"p.xp.addr.i <- alloca(\\\22int*\\\22)"}
!13 = !{!"p.yp.addr.i <- alloca(\\\22int*\\\22)"}
!14 = !{!"p.temp.i <- alloca(\\\22int\\\22)"}
!15 = !{!"p.retval <- alloca(\\\22int\\\22)"}
!16 = !{!"store(0, p.retval)"}
!17 = !{!"store(ptr(c.x), p.xp.addr.i)"}
!18 = !{!"store(ptr(c.y), p.yp.addr.i)"}
!19 = !{!"p.0 <- load(p.xp.addr.i)"}
!20 = !{!"v.1 <- load(p.0)"}
!21 = !{!"store(v.1, p.temp.i)"}
!22 = !{!"p.2 <- load(p.yp.addr.i)"}
!23 = !{!"v.3 <- load(p.2)"}
!24 = !{!"p.4 <- load(p.xp.addr.i)"}
!25 = !{!"store(v.3, p.4)"}
!26 = !{!"v.5 <- load(p.temp.i)"}
!27 = !{!"p.6 <- load(p.yp.addr.i)"}
!28 = !{!"store(v.5, p.6)"}
!29 = !{!"v.7 <- load(ptr(c.x))"}
!30 = !{!".ret <- ret(v.7); entry <- T"}
