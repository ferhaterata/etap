; ModuleID = './.llvm/input.ll'
source_filename = "./input/get_sign.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.1 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @checkpoint() #0 !reliability !2 !reliability !3 !intermittent !4 !intermittent !5 {
entry:
  ret void
}

; Function Attrs: alwaysinline nounwind uwtable
define dso_local i32 @get_sign(i32 %x) #1 !distribution !6 {
entry:
  %cmp = icmp eq i32 %x, 0
  br i1 %cmp, label %if.then, label %if.end, !probability !7

if.then:                                          ; preds = %entry
  br label %return

if.end:                                           ; preds = %entry
  %cmp1 = icmp slt i32 %x, 0
  br i1 %cmp1, label %if.then2, label %if.else, !probability !8

if.then2:                                         ; preds = %if.end
  br label %return

if.else:                                          ; preds = %if.end
  br label %return

return:                                           ; preds = %if.else, %if.then2, %if.then
  %retval.0 = phi i32 [ 0, %if.then ], [ -1, %if.then2 ], [ 1, %if.else ]
  ret i32 %retval.0
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
entry:
  %retval.i = alloca i32, align 4
  %x.addr.i = alloca i32, align 4
  %retval = alloca i32, align 4
  %i = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  store i32 0, i32* %retval, align 4, !reliability !9
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 3
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  call void @checkpoint()
  %1 = bitcast i32* %a to i8*
  %call = call i32 (i8*, i8*, ...) @read(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i64 0, i64 0), i8* %1), !reliability !10, !distribution !11, !probability !12
  %2 = load i32, i32* %a, align 4
  store i32 %2, i32* %x.addr.i, align 4
  %3 = load i32, i32* %x.addr.i, align 4
  %cmp.i = icmp eq i32 %3, 0
  br i1 %cmp.i, label %if.then.i, label %if.end.i, !probability !7

if.then.i:                                        ; preds = %for.body
  store i32 0, i32* %retval.i, align 4
  br label %get_sign.exit

if.end.i:                                         ; preds = %for.body
  %4 = load i32, i32* %x.addr.i, align 4
  %cmp1.i = icmp slt i32 %4, 0
  br i1 %cmp1.i, label %if.then2.i, label %if.else.i, !probability !8

if.then2.i:                                       ; preds = %if.end.i
  store i32 -1, i32* %retval.i, align 4
  br label %get_sign.exit

if.else.i:                                        ; preds = %if.end.i
  store i32 1, i32* %retval.i, align 4
  br label %get_sign.exit

get_sign.exit:                                    ; preds = %if.else.i, %if.then2.i, %if.then.i
  %5 = load i32, i32* %retval.i, align 4
  store i32 %5, i32* %b, align 4
  %6 = load i32, i32* %b, align 4
  %call2 = call i32 (i8*, ...) @write(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i64 0, i64 0), i32 %6), !reliability !13
  call void @checkpoint()
  br label %for.inc

for.inc:                                          ; preds = %get_sign.exit
  %7 = load i32, i32* %i, align 4
  %inc = add nsw i32 %7, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond, !llvm.loop !14, !reliability !16

for.end:                                          ; preds = %for.cond
  ret i32 0
}

declare dso_local i32 @read(i8*, i8*, ...) #2

declare dso_local i32 @write(i8*, ...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { alwaysinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!2 = !{!"Reliability Energy Cost Fixed; 10"}
!3 = !{!"Reliability Timing Cost Fixed; 15"}
!4 = !{!"Intermittent Capacitor 100,2000"}
!5 = !{!"Intermittent Checkpoint"}
!6 = !{!"x <- DiscreteDistribution(supp = -1000:1000)"}
!7 = !{!"Probability Model Count 1"}
!8 = !{!"Probability Model Count 1000", !"Probability Model Count 1000"}
!9 = !{!"Reliability Analysis Start"}
!10 = !{!"Reliability Energy CostFixed; 25", !"Reliability Timing Cost; Norm(mean=15,sd=3)"}
!11 = !{!"a <- DiscreteDistribution(supp = -1000:1000)"}
!12 = !{!"Probability External Event", !"Probability Behaviour; Norm(mean=100,sd=50)"}
!13 = !{!"Reliability Energy Cost; Norm(mean=25,sd=5)", !"Reliability Timing CostFixed; 180"}
!14 = distinct !{!14, !15}
!15 = !{!"llvm.loop.unroll.full"}
!16 = !{!"Reliability Analysis End"}
