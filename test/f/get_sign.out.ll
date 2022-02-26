; ModuleID = 'test/f/get_sign.ll'
source_filename = "./input/get_sign.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.1 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @checkpoint() #0 !reliability !2 !reliability !3 !intermittent !4 !intermittent !5 {
entry:
  ret void, !store !6
}

; Function Attrs: alwaysinline nounwind uwtable
define dso_local i32 @get_sign(i32 %x) #1 !distribution !7 !store !8 {
entry:
  %cmp = icmp eq i32 %x, 0, !store !9
  br i1 %cmp, label %if.then, label %if.end, !probability !10, !store !11

if.then:                                          ; preds = %entry
  br label %return, !store !12

if.end:                                           ; preds = %entry
  %cmp1 = icmp slt i32 %x, 0, !store !13
  br i1 %cmp1, label %if.then2, label %if.else, !probability !14, !store !15

if.then2:                                         ; preds = %if.end
  br label %return, !store !16

if.else:                                          ; preds = %if.end
  br label %return, !store !17

return:                                           ; preds = %if.else, %if.then2, %if.then
  %retval.0 = phi i32 [ 0, %if.then ], [ -1, %if.then2 ], [ 1, %if.else ]
  ret i32 %retval.0, !store !18
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
entry:
  %retval.i = alloca i32, align 4, !store !19
  %x.addr.i = alloca i32, align 4, !store !20
  %retval = alloca i32, align 4, !store !21
  %i = alloca i32, align 4, !store !22
  %a = alloca i32, align 4, !store !23
  %b = alloca i32, align 4, !store !24
  store i32 0, i32* %retval, align 4, !reliability !25, !store !21
  store i32 0, i32* %i, align 4, !store !22
  br label %for.cond, !store !26

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4, !store !27
  %cmp = icmp slt i32 %0, 3, !store !28
  br i1 %cmp, label %for.body, label %for.end, !store !29

for.body:                                         ; preds = %for.cond
  call void @checkpoint()
  %1 = bitcast i32* %a to i8*
  %call = call i32 (i8*, i8*, ...) @read(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i64 0, i64 0), i8* %1), !reliability !30, !distribution !31, !probability !32
  %2 = load i32, i32* %a, align 4, !store !33
  store i32 %2, i32* %x.addr.i, align 4, !store !34
  %3 = load i32, i32* %x.addr.i, align 4, !store !35
  %cmp.i = icmp eq i32 %3, 0, !store !36
  br i1 %cmp.i, label %if.then.i, label %if.end.i, !probability !10, !store !37

if.then.i:                                        ; preds = %for.body
  store i32 0, i32* %retval.i, align 4, !store !19
  br label %get_sign.exit, !store !38

if.end.i:                                         ; preds = %for.body
  %4 = load i32, i32* %x.addr.i, align 4, !store !39
  %cmp1.i = icmp slt i32 %4, 0, !store !40
  br i1 %cmp1.i, label %if.then2.i, label %if.else.i, !probability !14, !store !41

if.then2.i:                                       ; preds = %if.end.i
  store i32 -1, i32* %retval.i, align 4, !store !42
  br label %get_sign.exit, !store !43

if.else.i:                                        ; preds = %if.end.i
  store i32 1, i32* %retval.i, align 4, !store !44
  br label %get_sign.exit, !store !45

get_sign.exit:                                    ; preds = %if.else.i, %if.then2.i, %if.then.i
  %5 = load i32, i32* %retval.i, align 4, !store !46
  store i32 %5, i32* %b, align 4, !store !47
  %6 = load i32, i32* %b, align 4, !store !48
  %call2 = call i32 (i8*, ...) @write(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i64 0, i64 0), i32 %6), !reliability !49
  call void @checkpoint()
  br label %for.inc, !store !50

for.inc:                                          ; preds = %get_sign.exit
  %7 = load i32, i32* %i, align 4, !store !51
  %inc = add nsw i32 %7, 1, !store !52
  store i32 %inc, i32* %i, align 4, !store !53
  br label %for.cond, !llvm.loop !54, !reliability !56, !store !57

for.end:                                          ; preds = %for.cond
  ret i32 0, !store !58
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
!6 = !{!"%ret <- NA"}
!7 = !{!"x <- DiscreteDistribution(supp = -1000:1000)"}
!8 = !{!"%x <- DiscreteDistribution(supp = -1000:1000)"}
!9 = !{!"%cmp <- %x - 0; %cmp <- p(%cmp)(0) - p(%cmp)(-1)"}
!10 = !{!"Probability Model Count 1"}
!11 = !{!"%entry%if.then <- round(%cmp, 2); %entry%if.end <- round(1 - %cmp, 2)"}
!12 = !{!"%if.then%return <- 1.00"}
!13 = !{!"%cmp1 <- %x - 0; %cmp1 <- p(%cmp1)(0)"}
!14 = !{!"Probability Model Count 1000", !"Probability Model Count 1000"}
!15 = !{!"%if.end%if.then2 <- round(%cmp1, 2); %if.end%if.else <- round(1 - %cmp1, 2)"}
!16 = !{!"%if.then2%return <- 1.00"}
!17 = !{!"%if.else%return <- 1.00"}
!18 = !{!"%ret <- %retval.0"}
!19 = !{!"%retval.i <- DiscreteDistribution(0)"}
!20 = !{!"%x.addr.i <- DiscreteDistribution(0)"}
!21 = !{!"%retval <- DiscreteDistribution(0)"}
!22 = !{!"%i <- DiscreteDistribution(0)"}
!23 = !{!"%a <- DiscreteDistribution(0)"}
!24 = !{!"%b <- DiscreteDistribution(0)"}
!25 = !{!"Reliability Analysis Start"}
!26 = !{!"%entry%for.cond <- 1.00"}
!27 = !{!"%0 <- %i"}
!28 = !{!"%cmp <- %0 - 3; %cmp <- p(%cmp)(0)"}
!29 = !{!"%for.cond%for.body <- round(%cmp, 2); %for.cond%for.end <- round(1 - %cmp, 2)"}
!30 = !{!"Reliability Energy CostFixed; 25", !"Reliability Timing Cost; Norm(mean=15,sd=3)"}
!31 = !{!"a <- DiscreteDistribution(supp = -1000:1000)"}
!32 = !{!"Probability External Event", !"Probability Behaviour; Norm(mean=100,sd=50)"}
!33 = !{!"%2 <- %a"}
!34 = !{!"%x.addr.i <- %2"}
!35 = !{!"%3 <- %x.addr.i"}
!36 = !{!"%cmp.i <- %3 - 0; %cmp.i <- p(%cmp.i)(0) - p(%cmp.i)(-1)"}
!37 = !{!"%for.body%if.then.i <- round(%cmp.i, 2); %for.body%if.end.i <- round(1 - %cmp.i, 2)"}
!38 = !{!"%if.then.i%get_sign.exit <- 1.00"}
!39 = !{!"%4 <- %x.addr.i"}
!40 = !{!"%cmp1.i <- %4 - 0; %cmp1.i <- p(%cmp1.i)(0)"}
!41 = !{!"%if.end.i%if.then2.i <- round(%cmp1.i, 2); %if.end.i%if.else.i <- round(1 - %cmp1.i, 2)"}
!42 = !{!"%retval.i <- DiscreteDistribution(-1)"}
!43 = !{!"%if.then2.i%get_sign.exit <- 1.00"}
!44 = !{!"%retval.i <- DiscreteDistribution(1)"}
!45 = !{!"%if.else.i%get_sign.exit <- 1.00"}
!46 = !{!"%5 <- %retval.i"}
!47 = !{!"%b <- %5"}
!48 = !{!"%6 <- %b"}
!49 = !{!"Reliability Energy Cost; Norm(mean=25,sd=5)", !"Reliability Timing CostFixed; 180"}
!50 = !{!"%get_sign.exit%for.inc <- 1.00"}
!51 = !{!"%7 <- %i"}
!52 = !{!"%inc <- %7 + 1"}
!53 = !{!"%i <- %inc"}
!54 = distinct !{!54, !55}
!55 = !{!"llvm.loop.unroll.full"}
!56 = !{!"Reliability Analysis End"}
!57 = !{!"%for.inc%for.cond <- 1.00"}
!58 = !{!"%ret <- 0"}
