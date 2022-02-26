; ModuleID = 'test/r/input/malloc.ll'
source_filename = "./input/malloc.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.Foo = type { i32 }

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @allocate() #0 !store !2 {
entry:
  %foo = alloca %struct.Foo*, align 8, !store !3
  %call = call noalias i8* @malloc(i64 4) #2
  %0 = bitcast i8* %call to %struct.Foo*
  store %struct.Foo* %0, %struct.Foo** %foo, align 8, !store !4
  %1 = load %struct.Foo*, %struct.Foo** %foo, align 8, !store !5
  %A = getelementptr inbounds %struct.Foo, %struct.Foo* %1, i32 0, i32 0
  store i32 12, i32* %A, align 4, !store !6
  %2 = load %struct.Foo*, %struct.Foo** %foo, align 8, !store !7
  %3 = bitcast %struct.Foo* %2 to i8*
  call void @free(i8* %3) #2
  ret void, !store !8
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #1

; Function Attrs: nounwind
declare dso_local void @free(i8*) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!2 = !{!"entry <- F"}
!3 = !{!"%foo <- \22Type is not supported: %struct.Foo*\22"}
!4 = !{!"%foo <- %0"}
!5 = !{!"%1 <- %foo"}
!6 = !{!"%A <- 12"}
!7 = !{!"%2 <- %foo"}
!8 = !{!"%ret <- NA; entry <- T"}
