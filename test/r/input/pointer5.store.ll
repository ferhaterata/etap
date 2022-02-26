; ModuleID = 'test/r/input/pointer5.ll'
source_filename = "./input/pointer5.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [27 x i8] c"The value of pointer is %u\00", align 1, !global !0

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !store !3 {
entry:
  %retval = alloca i32, align 4, !store !4
  %p = alloca i32*, align 8, !store !5
  store i32 0, i32* %retval, align 4, !store !6
  store i32* null, i32** %p, align 8, !store !7
  %0 = load i32*, i32** %p, align 8, !store !8
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str, i64 0, i64 0), i32* %0)
  ret i32 0, !store !9
}

declare dso_local i32 @printf(i8*, ...) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!1}
!llvm.ident = !{!2}

!0 = !{!"c..str <- env(\\\220\\\22 = 84, \\\221\\\22 = 104, \\\222\\\22 = 101, \\\223\\\22 = 32, \\\224\\\22 = 118, \\\225\\\22 = 97, \\\226\\\22 = 108, \\\227\\\22 = 117, \\\228\\\22 = 101, \\\229\\\22 = 32, \\\2210\\\22 = 111, \\\2211\\\22 = 102, \\\2212\\\22 = 32, \\\2213\\\22 = 112, \\\2214\\\22 = 111, \\\2215\\\22 = 105, \\\2216\\\22 = 110, \\\2217\\\22 = 116, \\\2218\\\22 = 101, \\\2219\\\22 = 114, \\\2220\\\22 = 32, \\\2221\\\22 = 105, \\\2222\\\22 = 115, \\\2223\\\22 = 32, \\\2224\\\22 = 37, \\\2225\\\22 = 117, \\\2226\\\22 = 0)"}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!3 = !{!"entry <- F"}
!4 = !{!"p.retval <- alloca(\\\22int\\\22)"}
!5 = !{!"p.p <- alloca(\\\22int*\\\22)"}
!6 = !{!"store(0, p.retval)"}
!7 = !{!"store(\\\22null\\\22, p.p)"}
!8 = !{!"p.0 <- load(p.p)"}
!9 = !{!"path.return <<- c(path.return, ret(0)); entry <- T"}
