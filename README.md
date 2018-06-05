# CMOTCF
BASELINE：CMOT https://motchallenge.net/tracker/TC_ODAL

Mycode: 
2DMOT2015
ILDA = 1  MOTA = 16.7
ILDA = 0  MOTA = 15.9

我的kcf CODE： MOTA = 20.4，较ILDA的方法，在训练集上提升了3.7个点

%% 上述结果都在2DMOT2015的train集上做的实验：
Train集包含的序列有：
% TUD-Stadtmitte      
% TUD-Campus          
% PETS09-S2L1         
% ETH-Bahnhof        
% ETH-Sunnyday        
% ETH-Pedcross2        
% ADL-Rundle-6        
% ADL-Rundle-8       
% KITTI-13            
% KITTI-17            
% Venice-2   
         
具体详情如下：
Mycode: kcf
Sequences: 
    'TUD-Stadtmitte'
    'TUD-Campus'
    'PETS09-S2L1'
    'ETH-Bahnhof'
    'ETH-Sunnyday'
    'ADL-Rundle-6'
    'ADL-Rundle-8'
    'KITTI-13'
    'KITTI-17'
    'ETH-Pedcross2'
    'Venice-2'

Evaluating ... 
	... TUD-Stadtmitte
*** 2D (Bounding Box overlap) ***
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 68.2 77.8 60.7| 68.3  87.5  0.63|   10   2    8    0|   113   367     5    14|  58.0  65.7  58.4 

	... TUD-Campus
*** 2D (Bounding Box overlap) ***
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 46.1 77.1 32.9| 38.7  90.8  0.20|    8   0    7    1|    14   220     2     7|  34.3  70.9  34.7 

	... PETS09-S2L1
*** 2D (Bounding Box overlap) ***
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 76.9 77.7 76.2| 85.3  83.8  0.93|   19  15    4    0|   738   658    28    87|  68.2  71.4  68.8 

	... ETH-Bahnhof
*** 2D (Bounding Box overlap) ***
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 48.1 58.4 40.8| 59.4  60.0  2.14|  171  37   60   74|  2144  2197    32   143|  19.2  73.2  19.8 

	... ETH-Sunnyday
*** 2D (Bounding Box overlap) ***
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 53.8 77.1 41.3| 48.9  89.0  0.32|   30   5   13   12|   112   950     6    28|  42.5  75.5  42.8 

	... ADL-Rundle-6
*** 2D (Bounding Box overlap) ***
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 34.3 40.3 29.9| 47.0  63.2  2.61|   24   0   20    4|  1370  2656    65    73|  18.3  72.6  19.6 

	... ADL-Rundle-8
*** 2D (Bounding Box overlap) ***
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 34.9 37.5 32.6| 44.5  51.3  4.39|   28   6   15    7|  2870  3762    38   115|   1.7  71.5   2.2 

	... KITTI-13
*** 2D (Bounding Box overlap) ***
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 24.3 44.8 16.7| 21.1  46.5  0.54|   42   0   12   30|   185   601     4     6|  -3.7  71.3  -3.2 

	... KITTI-17
*** 2D (Bounding Box overlap) ***
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 52.9 83.5 38.7| 48.3  90.9  0.23|    9   0    7    2|    33   353     7    13|  42.5  70.5  43.4 

	... ETH-Pedcross2
*** 2D (Bounding Box overlap) ***
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 17.1 63.1  9.9| 11.9  70.3  0.38|  133   0   20  113|   314  5520    10    47|   6.7  69.1   6.8 

	... Venice-2
*** 2D (Bounding Box overlap) ***
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 38.1 38.5 37.7| 54.7  55.8  5.14|   26   4   19    3|  3087  3236    65   102|  10.5  72.8  11.4 


 ********************* Your Benchmark Results (2D) ***********************
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 21.3 25.8 18.2| 48.6  63.8  2.00|  500  69  185  246| 10980 20520   262   635|  20.4  72.0  21.1
 
ILDA = 1 时，
Sequences: 
    'TUD-Stadtmitte'
    'TUD-Campus'
    'PETS09-S2L1'
    'ETH-Bahnhof'
    'ETH-Sunnyday'
    'ETH-Pedcross2'
    'ADL-Rundle-6'
    'ADL-Rundle-8'
    'KITTI-13'
    'KITTI-17'
    'Venice-2'

Evaluating ... 
	... TUD-Stadtmitte
*** 2D (Bounding Box overlap) ***
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 58.9 61.9 56.1| 68.9  75.9  1.41|   10   3    7    0|   253   360    15    22|  45.7  65.5  46.9 

	... TUD-Campus
*** 2D (Bounding Box overlap) ***
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 58.4 80.8 45.7| 51.5  91.1  0.25|    8   0    7    1|    18   174     1     8|  46.2  70.5  46.4 

	... PETS09-S2L1
*** 2D (Bounding Box overlap) ***
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 67.6 63.9 71.8| 89.5  76.6  1.54|   19  15    4    0|  1226   471    38    97|  61.2  71.1  62.1 

	... ETH-Bahnhof
*** 2D (Bounding Box overlap) ***
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 41.1 45.4 37.6| 65.4  55.8  2.80|  171  50   58   63|  2802  1872    49   191|  12.8  72.0  13.7 

	... ETH-Sunnyday
*** 2D (Bounding Box overlap) ***
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 56.3 75.2 45.0| 51.7  84.4  0.50|   30   5   12   13|   177   898     8    30|  41.7  74.8  42.1 

	... ETH-Pedcross2
*** 2D (Bounding Box overlap) ***
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 17.9 59.0 10.6| 13.2  68.3  0.46|  133   0   22  111|   383  5436    12    54|   6.9  69.1   7.1 

	... ADL-Rundle-6
*** 2D (Bounding Box overlap) ***
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 33.3 35.9 31.1| 53.7  62.1  3.13|   24   3   19    2|  1642  2319    75   102|  19.4  71.1  20.9 

	... ADL-Rundle-8
*** 2D (Bounding Box overlap) ***
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 34.8 34.8 34.7| 46.5  46.7  5.51|   28   6   15    7|  3603  3626    44   141|  -7.2  70.9  -6.6 

	... KITTI-13
*** 2D (Bounding Box overlap) ***
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 23.8 38.3 17.2| 21.9  40.0  0.74|   42   0   14   28|   251   595     3     6| -11.4  71.3 -11.1 

	... KITTI-17
*** 2D (Bounding Box overlap) ***
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 57.9 84.4 44.1| 53.3  89.0  0.31|    9   0    7    2|    45   319     3    13|  46.3  70.1  46.6 

	... Venice-2
*** 2D (Bounding Box overlap) ***
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 35.9 35.1 36.7| 57.1  54.6  5.65|   26   6   17    3|  3390  3064    68   112|   8.7  72.6   9.6 


 ********************* Your Benchmark Results (2D) ***********************
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 20.0 22.5 18.0| 52.1  60.1  2.51|  500  88  182  230| 13790 19134   316   776|  16.7  71.4  17.5 

ILDA = 0 时，
Sequences: 
    'TUD-Stadtmitte'
    'TUD-Campus'
    'PETS09-S2L1'
    'ETH-Bahnhof'
    'ETH-Sunnyday'
    'ETH-Pedcross2'
    'ADL-Rundle-6'
    'ADL-Rundle-8'
    'KITTI-13'
    'KITTI-17'
    'Venice-2'

Evaluating ... 
	... TUD-Stadtmitte
*** 2D (Bounding Box overlap) ***
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 59.1 62.5 56.1| 71.5  79.8  1.17|   10   4    6    0|   209   329    11    21|  52.5  65.3  53.4 

	... TUD-Campus
*** 2D (Bounding Box overlap) ***
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 56.7 78.0 44.6| 50.7  88.8  0.32|    8   0    7    1|    23   177     3     9|  43.5  70.1  44.1 

	... PETS09-S2L1
*** 2D (Bounding Box overlap) ***
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 58.6 55.3 62.3| 88.7  75.8  1.59|   19  17    2    0|  1267   505    51   109|  59.3  70.9  60.4 

	... ETH-Bahnhof
*** 2D (Bounding Box overlap) ***
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 41.1 45.1 37.8| 65.1  54.9  2.90|  171  51   56   64|  2896  1890    65   192|  10.4  72.0  11.6 

	... ETH-Sunnyday
*** 2D (Bounding Box overlap) ***
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 56.5 72.2 46.4| 54.2  82.4  0.61|   30   6   12   12|   215   851     5    31|  42.4  74.7  42.6 

	... ETH-Pedcross2
*** 2D (Bounding Box overlap) ***
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 18.6 59.3 11.0| 14.1  70.2  0.45|  133   1   21  111|   374  5380    10    59|   8.0  68.7   8.1 

	... ADL-Rundle-6
*** 2D (Bounding Box overlap) ***
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 35.8 37.8 33.9| 55.5  61.9  3.26|   24   3   19    2|  1711  2228    67    93|  20.0  71.2  21.3 

	... ADL-Rundle-8
*** 2D (Bounding Box overlap) ***
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 34.1 33.6 34.6| 47.4  46.1  5.76|   28   6   15    7|  3770  3565    49   146|  -8.9  70.9  -8.2 

	... KITTI-13
*** 2D (Bounding Box overlap) ***
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 22.5 34.0 16.8| 22.7  37.7  0.84|   42   0   15   27|   286   589     5     6| -15.5  70.5 -14.9 

	... KITTI-17
*** 2D (Bounding Box overlap) ***
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 60.0 85.9 46.0| 53.3  86.9  0.38|    9   0    7    2|    55   319     2    13|  44.9  70.2  45.2 

	... Venice-2
*** 2D (Bounding Box overlap) ***
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 37.6 36.0 39.4| 58.4  53.4  6.06|   26   8   15    3|  3635  2969    60   114|   6.7  72.5   7.5 


 ********************* Your Benchmark Results (2D) ***********************
 IDF1  IDP  IDR| Rcll  Prcn   FAR|   GT  MT   PT   ML|    FP    FN   IDs    FM|  MOTA  MOTP MOTAL 
 19.3 21.3 17.6| 52.9  59.4  2.63|  500  96  175  229| 14441 18802   328   793|  15.9  71.3  16.7 
 
