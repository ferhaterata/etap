; ModuleID = 'test/r/input/struct7.ll'
source_filename = "./input/struct7.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.S = type { [2 x i32] }

@buf = dso_local global %struct.S { [2 x i32] [i32 0, i32 1] }, align 4, !global !0

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !store !3 {
entry:
  %retval = alloca i32, align 4, !store !4
  %p = alloca %struct.S*, align 8, !store !5
  store i32 0, i32* %retval, align 4, !store !6
  store %struct.S* @buf, %struct.S** %p, align 8, !store !7
  store i32 3, i32* getelementptr inbounds (%struct.S, %struct.S* @buf, i32 0, i32 0, i64 1), align 4, !store !8
  %0 = load %struct.S*, %struct.S** %p, align 8, !store !9
  %data = getelementptr inbounds %struct.S, %struct.S* %0, i32 0, i32 0, !store !10
  %arraydecay = getelementptr inbounds [2 x i32], [2 x i32]* %data, i64 0, i64 0, !store !11
  %add.ptr = getelementptr inbounds i32, i32* %arraydecay, i64 1, !store !12
  %1 = load i32, i32* %add.ptr, align 4, !store !13
  ret i32 %1, !store !14
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!1}
!llvm.ident = !{!2}

!0 = !{!"c.buf <- env(\\\220\\\22 = list(\\\220\\\22 = 0, \\\221\\\22 = 1))"}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!3 = !{!"entry <- F"}
!4 = !{!"p.retval <- alloca(\\\22int\\\22)"}
!5 = !{!"p.p <- alloca(\\\22struct*\\\22)"}
!6 = !{!"store(0, p.retval)"}
!7 = !{!"store(ptr(c.buf), p.p)"}
!8 = !{!"store(3, gep(ptr(c.buf), 0, 0, 1))"}
!9 = !{!"p.0 <- load(p.p)"}
!10 = !{!"p.data <- gep(p.0, 0, 0)"}
!11 = !{!"p.arraydecay <- gep(p.data, 0, 0)"}
!12 = !{!"p.add.ptr <- gep(p.arraydecay, 1)"}
!13 = !{!"v.1 <- load(p.add.ptr)"}
!14 = !{!".ret <- ret(v.1); entry <- T"}
