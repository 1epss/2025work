#import "template.typ": *
#import "fitheight.typ": *
#import "@preview/codelst:2.0.0": sourcecode

#show: project.with(
  title: "Numerical method for geophysics ",
  subtitle: "2025년 1학기 지구물리수치해석 수업 정리",
  authors: (
    "두민규",
  ),
  main: "image/main.png")

#show <r>: set text(red)

#show <b>: set text(blue)

#let zz = $arrow.r.curve$

#set figure(supplement: none)

#set text(size: 8pt)
  
#set enum(spacing:1em,
          //numbering: "1)",//
          //tight: false,//
          //body-indent :,//
          full:false,
          indent:1em)
          
#set list(marker: ([＃], [-], [-]),
          //body-indent: 1em//
          indent:0.4em)

#set math.equation(numbering: "(1)", supplement: [Eq.])

= Introduction
- Signal distortion
 - 지진학의 주된 문제 중 하나로, Original source의 신호를 기타 effect들로부터 구분하는 문제가 있음 \ #zz 지표면 위의 관측소에 기록된 지반 진동은 실제 source에서 생성된 지진 신호(Seismic signal)와 매우 다른 모습을 가짐
 1. 지진파의 전파 과정 중 감쇠(Attenuation)에 의해 주파수 별로 진폭의 감소와 위상의 변화(Phase shift)가 나타날 수 있음
 2. 지진파의 분산(Scattering)은 다른 경로로 전파되는 Wavelet의 복잡한 중첩을 야기할 것임 
 3. 천부 퇴적층에서 일어날 수 있는 지진파의 Reverberation은 주파수에 따른 진폭의 증폭 효과를 낼 수 있음
 4. 지진파를 기록하는 시스템과 샘플링 과정에서 추가적인 신호의 왜곡을 초래할 수 있음
 - 지진파가 전파 시 어떻게 변화하는지, 지진계의 신호처리 방법을 이해하면 지진파 분석을 통해 Source, 매질의 상태 추정 가능
- Influence of recording system
 - 1999.8.17 Izmit 지진에서 수집한 수직성분의 지진파형으로부터 센서와 기록계가 지진파형에 영향을 주는 것을 볼 수 있음 \ #zz 약 29.8도 떨어진 거리의 세 개의 다른 지진 파형을 도시하였고, 지진계별로 신호의 다른 주파수 성분을 강조(emphasize) \ #zz Source로부터 지진 신호가 나타나는 것을 해석하기에 앞서, 기록되는 과정에서 발생할 수 있는 effect들에 대해 이해 필요
#fitminHeight(([#image("image/1-1.png")], [#image("image/1-2.png")],), gutter: 0.5cm)
- Typical signal processing steps
 - 우리가 사용하는 지진계는 100Hz의 주파수를 가지는 지진파형으로, 나이퀴스트 주파수는 50Hz \ #zz 60Hz의 일정한 주파수를 가지는(Monochromatic) 교류 전류 신호가 중첩되어 일종의 잡음처럼 나타나는(Crosstalk) 상황 \ #zz 아래 그림은 단주기 속도계의 수직 성분 중 두 개의 파형에서 잡음을 제거한 파형으로, Notch filter를 적용한 것으로 여김
#fitminHeight(([#image("image/1-3.png")], [#image("image/1-4.png")],), gutter: 0.5cm)
- Frequency response function
 - 신호를 복원하거나 Instrument를 모사할 때 사용되는 과정으로 Transfer function과 Frequency response function이 있음 \ #zz Transfer function은 입력 신호에 대한 일종의 시스템의 응답을 표현하는 함수로, 지진계의 경우 Pole과 Zero로 표현 \ #zz Frequency function은 주파수에 따른 증폭을 시각화하거나, 지진계에 따른 지진 신호의 감쇠를 살펴보는데 용이함 \ #zz 아래 그림은 USGS 단주기 속도계의 Frequency function으로, 약 10\~100Hz의 신호가 지진파형에서 우세하게 나타날 것
- Correction for the instrument response
 - 지진을 기록하는 시스템의 특징을 설명할 수 있으면, 시스템과 지반 운동이 어떻게 상호작용하는지 알 수 있을 것임 \ #zz 이 때 사용되는 방법에 Convolution과 Deconvolution이 있고, 이 들은 각각의 장단점이 존재함
#fitminHeight(([#image("image/1-5.png")], [#image("image/1-4.png")],[#image("image/1-6.png")]), gutter: 0.5cm)
- Spectral analysis
 - 이전 그림의 P파를 푸리에 변환하여 주파수 대역에서 신호를 해석할 수 있음 \ #zz 지진 신호에 대해 계기응답을 보정해주고 나면 이를 역산해 Source parameter를 결정할 수 있음 \ #zz 이를 이용해 지진 모멘트 $M_0$의 추정치를 계산할 수 있고, 이는 진원의 크기, 변위의 곱에 비례하며 Stress drop, 감쇠와 관련
 - 그림은 전형적인 변위 스펙트럼의 모습으로, 저주파수에서는 진폭이 평평하고, 고주파수 에서는 주파수에 따라 급격히 감소 \ #zz 이 두 영역이 전환되는 부분이 모서리 주파수 $f_c$로, 신호의 스펙트럼 진폭이 저주파수 진폭 크기의 절반이 되는 주파수 \ #zz 저주파수의 진폭으로부터는 지진의 규모를 얻을 수 있고, 모서리 주파수로부터는 단층의 크기를 얻을 수 있음
- Displacement spectrum
 - P파나 S파 신호의 변위 스펙트럼은 주파수 영역에서 곱셈(시간 영역에서는 합성곱)을 이용해 보다 쉽게 표현할 수 있음
 $ S(f) = A(f) dot I(f) dot R(f) dot B(f) $ <1> #h(1.3em) #zz $S(f)$는 P,S파 스펙트럼, $R(f)$는 부지 응답, $A(f)$는 Far-field source 스펙트럼, $B(f)$는 감쇠의 스펙트럼, $I(f)$는 계기응답 \ #h(1.3em) #zz $R(f), B(f)$를 묶어 Path effect라고도 표현함
 - Far-field의 Source 스펙트럼은 다음과 같고, 이로부터 $M_0, f_c$ 등을 얻을 수 있음
 $ A(f) = frac(M_0 R(theta, phi), 4 pi rho s v^3) dot frac(f_c^gamma, f_c^gamma + f^gamma) $
 - 감쇠 스펙트럼은 다음과 같고, 감쇠 상수 $Q$는 특정 거리에서의 에너지 $E$를 이용해 다음과 같이 나타낼 수 있음
 $ B(f) = e^(frac(pi f s, v Q)) = e^(frac(pi f t, Q)) #h(3em) Q = -frac(2 pi E ,Delta E) $
 - 감쇠 상수 $Q$, 매질의 Elastic parameter들과 부지 응답 $R(f)$를 안다면, @1 을 직접 이용해 스펙트럼을 역산해 Source parameter를 계산할 수 있음
- Wavelet parameters of seismograms
 - 실제 지반 진동을 분석하기 보다는 실제 혹은 모사된 지진계로부터 얻은 기록을 이용해 지진파형을 해석함 \ #zz 따라서 일반적으로 소수의 Signal parameter 들만 분석되어짐 \ #zz 피킹의 위치와 진폭($t_01, t_max ... $), 규모 결정, Duration, Signal moment, Envelope function... 등을 이용해 자동화된 분석 가능  
#fitminHeight(([#image("image/1-7.png")], [#image("image/1-8.png")]), gutter: 0.5cm)
\ \ \
- Filter or system
  - 지진파형으로부터 정보를 복원하는 데 신호처리 과정은 매우 중요하지만, 그 과정이 가지는 고유의 한계가 존재 \ #zz 필터 혹은 시스템은 물리적인 개념으로는 Device, 수학적인 개념으로는 Algorithm으로 표현 가능 \ #zz 어떠한 입력 신호를 다른 형태를 가질 수 있는 출력 신호의 형태로 나타내는 역할을 수행함
  - Source로부터 지진파형을 얻는 과정을 나타낸 그림이며, 왼쪽과 오른쪽을 각각의 분류된 시스템으로 가정하기도 함
- Cource rationale
 - 먼저 시스템이 가지는 수학적 정의, 표현, 영향을 표현할 줄 알아야하며, 신호에서 어떻게 작용할 것인지를 배워야 함
 - 만약 시스템이 선형-시불변의 시스템이라면, 그림의 시스템 상자 안에서 어떠한 일이 진행되는지를 알 필요가 없음 \ #zz 선형성(Linearity)는 입력 신호와 출력 신호의 비례관계 및 예측성을 의미하며, 시스템의 중첩시에도 특성을 유지하게 됨 \ #zz 시불변(time invariance) 시스템은 시간에 따른 변화가 없는 안정한(Stable) 시스템을 의미함 \ #zz 시스템의 특성과 입력 신호의 변화 과정을 설명하려면 시스템이 임펄스, Sin파 등 입력 신호를 어떻게 변화시키는지 확인
 - 시스템은 주파수 대역에서 가장 편리하게 표현될 수 있으며, 시간 영역에서 푸리에 변환 또는 라플라스 변환을 통해 연결됨
#fitminHeight(([#image("image/1-9.png")], [#image("image/1-10.png")]), gutter: 0.5cm)
#pagebreak()
= RC Filter
== The system diagram
- The system diagram
 - 축전기(Capacitor, $C$)와 저항(Resistor, $R$)으로 구성된 간단한 필터(RC 필터)를 이용해 시스템에 대한 기초를 이해할 수 있음 \ #zz 간단한 시스템으로, 시스템의 물리적 및 비물리적 특성을 정량화하는 다양한 방법을 비교하는 데 활용할 수 있음
 - 

#fitminHeight(([#image("image/2-1.png")], [#image("image/2-2.png")]), gutter: 0.5cm)
== The differential equation





== The frequency response function and the Fourier transform































#pagebreak()
= Introduction
- Introduction
 - 작은 지진의 단층면해는 주로 P파의 초동 극성을 이용해 결정할 수 있는데, 불완전한 속도 구조모델 등 오차를 발생시키는 여러 원인에 대해 매우 민감한 특성을 가진다. 이러한 문제를 해결하기 위해 개발된 것이 HASH(HArdeback & SHearer)로, 새로운 방법을 이용해 더욱 안정적인 단층면해를 계산할 수 있다. HASH는 불확실성을 야기하는 다양한 요소들이 주어졌을 때, 각 지진에 대해 허용될 수 있는 단층면해들을 생성하고, 그 중 가장 높은 가능성을 가지는 결과를 출력한다. 결정된 단층면해의 정확도는 모델이 가지는 불확실성에 대해 계산된 해의 안정성 정도에 따라 결정되며, 이는 허용될 수 있는 단층면해들의 분포로 표현할 수 있다. 
 - 본 매뉴얼은 연구자들이 각자의 데이터셋을 이용해 HASH를 실행하는 것을 돕기 위해 작성되었으며, 소스코드는 다음의 주소#footnote[https://www.usgs.gov/node/279393 (24.12.25 기준)] 를 참고하라. 더 자세한 방법은 저자의 출판물에서 확인할 수 있으며, 연구에 해당 코드를 사용하였다면 다음의 논문들을 인용하길 바란다.
 #block(
  fill: luma(230),
  inset: 8pt,
  radius: 4pt,
  text[1. Hardebeck, Jeanne L. and Peter M. Shearer, A new method for determining first-motion focal mechanisms, Bulletin of the Seismological Society of America, 92, 2264-2276, 2002.
  2. Hardebeck, Jeanne L. and Peter M. Shearer, Using S/P Amplitude Ratios to Constrain the Focal Mechanisms of Small Earthquakes, Bulletin of the Seismological Society of America, 93, 2434-2444, 2003.])
 - HASH는 P파의 초동 극성(또는 S/P파의 진폭비) 기반 단층면해를 결정하기 위해 격자 탐색법을 이용하며, 그 결과 각 지진에 대해 허용될 수 있는 해들을 얻을 수 있다. 이 해들의 분포를 통해 불확실성 및 그에 동반하는 해의 정확도가 결정되어진다. 얻어진 해들은 측정한 P파의 극성과 진원의 위치, 출발각(속도 구조모델)의 불확실성을 고려하기 때문에, 따라서 이 각각의 불확실성이 어떠한 값을 가지는지에 대한 추정치가 필요하다.
 - HASH는 입/출력 작업을 처리하고, 입력 데이터를 내부의 배열로 불러오는 역할을 수행하는 메인 드라이버 코드와 단층면해, 불확실성을 계산하며 관측소의 위치와 속도 구조모델을 다루는 서브루틴 코드로 구성되어진다. HASH는 입력 데이터의 형식에 의존되지 않는 프로그램으로, 만약 다른 형식의 데이터를 사용한다면 메인 드라이버 코드와 관측소 서브루틴만 수정함으로서 간단히 작업을 수행할 수 있다. 
 - HASH는 SCSN(Southern California Seismic Network; TriNet)#footnote[Southern California Seismic Network] 이 수집하고 SCEDC(Southern California Earthquake Data Center)#footnote[Southern California Earthquake Data Center] 이 제공한 데이터를 이용해 개발되었으며, 따라서 본 매뉴얼의 예시는 SCEDC 지진파 위상 데이터의 표준 배포 형식에 유사한 형식을 가진다. 또한 HASH는 기존 단층면해 결정에 널리 쓰이는 FPFIT#footnote[Reasenberg & Oppenheimer (1985)] 를 참조하였다. HASH 1.2 버전에 추가된 Example 4는 2008년 1월 기준 SCEDC의 지진파 위상과 관측소 표준 형식을 따랐으며, 따라서 다섯 글자의 관측소명을 가지는 관측소를 포함한다.
 - HASH는 Fortran 77로 작성되었으며, 다양한 환경의 Sun 워크스테이션 및 Linux, Mac OS X에서 다음과 같은 컴파일러#footnote[http://fink.sourceforge.net/] 를 이용해 테스트되었다. 다른 환경에서 작동하기 위해 변경사항이 필요하거나, 버그를 발견한다면 저자에게 연락해주길 바란다. 
#pagebreak()
= Overview
- HASH 폴더 내에는 다음과 같은 파일들이 존재해야 한다.
 - 소스 코드 
  #block(fill: luma(230), inset: 8pt, radius: 4pt,
  list(marker:([•]),
  [hash_driver1.f, hash_driver2.f, hash_driver3.f : 메인 드라이버 프로그램],
  [hash_driver4.f : SCEDC 표준 형식을 따르며 5글자의 관측소명을 가짐],
  [hash_driver5.f : 3차원 지진파 트레이싱에 사용되는 SIMULPS 형식을 따름],
  [fmamp_subs.f : P파의 초동 극성과 S/P 진폭비를 이용해 단층면해를 계산하는 서브루틴],
  [fmech_subs.f : P파의 초동 극성만을 이용해 단층면해를 계산하는 서브루틴],
  [pol_subs.f : 초동 극성의 분포와 오차를 계산하는 서브루틴],
  [station_subs.f : 관측소의 위치와 초동 극성의 반전과 관련된 서브루틴],
  [station_subs_5char.f : (새로 추가) 다섯 글자의 관측소명을 가진 관측소 위치와 초동 극성의 반전과 관련된 서브루틴],
  [uncert_subs.f : 단층면해의 불확실성을 계산하는 서브루틴],
  [utils_subs.f : 기타 유틸리티를 포함한 서브루틴],
  [vel_subs.f : 속도 구조모델 테이블에 관한 서브루틴]))
 - 설정 파일(Include files)
  #block(fill: luma(230), inset: 8pt, radius: 4pt,
  list(marker:([•]),
  [param.inc : 배열의 크기를 조절하기 위한 매개변수들 조정],
  [rot.inc : 격자 검색법에 사용되는 격자의 간격 결정],
  [vel.inc : 속도 구조모델 테이블 관련 매개변수 조정]))
 - Makefile
  #block(fill: luma(230), inset: 8pt, radius: 4pt,
  list(marker:([•]),
  [Makefile],))
 - 예제 컨트롤 파일
  #block(fill: luma(230), inset: 8pt, radius: 4pt,
  list(marker: ([•]),
  [example1.inp : P파의 초동 극성을 이용하여 계산할 때 사용, 출발각의 불확실성을 직접 입력],
  [example2.inp : P파의 초동 극성을 이용하여 계산할 때 사용, 1차원 속도 구조모델들을 이용해 출발각의 불확실성 입력],
  [example3.inp : P파의 초동 극성과 S/P 진폭비를 모두 이용하여 계산할 때 사용, 1차원 속도 구조모델들을 이용해 출발각의 불확실성 입력],
  [example4.inp : example2.inp와 같지만 갱신된 SCEDC의 형식을 따름],
  [example5.inp : example2.inp와 같지만 SIMULPS 형식의 파일으로부터 방위각과 출발각을 이용]))
 - 예제 데이터 파일
  #block(fill: luma(230), inset: 8pt, radius: 4pt,
  list(marker: ([•]),
  [north1.phase : example1에 사용되는 P파의 초동 극성 파일],
  [north2.phase : example2,3에 사용되는 P파의 초동 극성 파일],
  [north3.amp : example3에 사용되는 P파와 S파의 진폭 파일],
  [north3.statcor : example3에 사용되는 관측소별 S/P 진폭비 보정 파일],
  [north4.phase : SCEDC 형식의 P파 초동 극성 파일],
  [north5.simul : SIMULPS 로부터 얻은 방위각과 출발각 파일],
  [scsn.stations : example2,3에 사용되는 관측소 위치 파일],
  [scsn.stations_5char : example4에 사용되는 다섯 글자 관측소 위치 파일],
  [scsn.reverse : 모든 예시에 사용되는 관측소별 초동 극성의 반전 파일],
  [vz.socal, etc : example2,3에 사용되는 1차원 속도 구조모델 파일]))
 - 예제 출력 파일
  #block(fill: luma(230), inset: 8pt, radius: 4pt,
  list(marker: ([•]),
  [example1.out, example2.out, example3.out, example4.out, example5.out : 각 예제에 맞는 최적의 단층면해 출력],
  [example1.out2, example2.out2, example4.out2, example5.out2 : 각 예제에 맞는 허용될 수 있는 단층면해들 출력]))
- 컴파일링 및 프로그램의 실행은 다음과 같이 진행할 수 있습니다.
  #block(
  fill: black,
  inset: 8pt,
  radius: 4pt,
  text([```bash # 컴파일링
  $ make hash_driverX                   # X = example number 
  
  # 프로그램 실행
  $ ./hash_driverX                      # 파일이 요구하는 입력 데이터를 직접 입력할 경우
  $ ./hash_driverX < exampleX.inp       # 컨트롤 파일을 이용하는 경우
  ```], white))
  - 코드가 성공적으로 컴파일 및 실행되었다면, 출력 파일은 제공된 예시와 거의 일치할 것이다. 출력된 결과가 샘플과 완전히 일치하지 않을 수 있는데, 이는 각 몬테카를로 시뮬레이션에 입력 데이터가 무작위로 선택되기 때문에, 난수의 생성에 차이가 발생하게 됨에 따라 차이가 발생하는 것으로 여길 수 있다.
#pagebreak()

= RUNNING THE CODE
== Computing Focal Mechanisms: 
- 단층면해 계산 
 - 메인 드라이버(프로그램)는 주로 입/출력 과정을 담당하며, 실제 지진별 단층면해의 계산은 메인 드라이버에서 호출되는 세 개의 서브루틴을 통해 수행되어진다. 메인 드라이버의 루틴들을 수정하여, 입력 데이터의 형식을 서브루틴이 받는 배열로 효율적으로 바꿔주어야 한다. 
- 허용될 수 있는 단층면해들의 계산
 - 계산 과정에 S/P 진폭비를 P파의 초동 극성과 함께 사용할 것인지 여부에 따라 별개의 유사한 서브루틴이 사용될 수 있다. 두 서브루틴 모두에 사용되는 입력 데이터로는 지진 발생 시 여러 관측소에서 측정한 P파의 초동 극성(과 S/P파 진폭비), 방위각과 출발각이 있다. 또한 이 입력 데이터들이 가지는 불확실성의 추정치는 단층면해의 안정성을 테스트하는데 필요하다.   
 - 방위각과 출발각이 가지는 불확실성은 서로 다른 진원 깊이, 속도 구조모델에 대해 수행된 반복적인 계산 과정에서 얻은 합리적인 수치들의 조합으로 나타난다. 진원 위치와 속도 구조모델을 고정해놓았다고 가정한 후 수행한 5번째 계산의 경우에서, 7번째 관측소에 대한 방위각과 출발각은 각각 #text("p_azi_mc(7,5), p_the_mc(7,5)", font:"Courier New")에 저장되며, 8번째 관측소에 대한 정보는 #text("p_azi_mc(8,5), p_the_mc(8,5)", font: "Courier New") 에 저장되어질 것이다. P파의 초동 극성과 발췌한 위상의 정확도, S/P 진폭비는 각각의 계산에서 같은 값을 가지며, 7번째 관측소에 대해 계산한 예시는 각각 #text("p_pol(7), p_qual(7), sp_amp(7)", font:"Courier New") 에 저장되어진다. 계산의 수행 횟수와 사용된 관측소의 개수는 각각 #text("nmc, npsta", font:"Courier New") 에서 정의된다. 각각의 계산 과정에서 허용 가능한 단층면해들이 생성될 것이며, 이것들을 결합하여 최종적으로 대상 지진에 대해 허용 가능한 단층면해들을 생성할 수 있다.
 - P파 초동 극성의 불확실성은 허용 가능한 초동 극성 오차의 개수를 지정함으로써 고려할 수 있으며, 출력되는 허용 가능한 단층면해들은 최대 이 개수만큼의 극성 오차를 가진 해들을 포함하는 것으로 여길 수 있다. 이때 허용된 극성 오차의 수는 최적의 단층면해가 가지는 극성 오차의 수에 추가로 #text("nextra", font:"Courier New") 가 더해진 값으로 정의된다. 만일 허용된 극성 오차의 수가 #text("ntotal", font:"Courier New") 보다 적다면, #text("ntotal", font:"Courier New") 이 허용된 극성 오차의 수로 사용될 것이다. 일반적으로, #text("ntotal", font:"Courier New") 은 초동 극성의 총 개수와 네트워크 내 알려진 극성 오차의 비율을 곱하기 때문에, 이를 바탕으로 극성 오차의 수를 예측할 수 있다. 주로 #text("ntotal", font:"Courier New")의 절반인 #text("nextra", font:"Courier New")를 사용한다. S/P 진폭비의 경우, 허용 가능한 $log_10 (S"/"P)$ 오차는 최적의 단층면해가 가지는 오차에 #text("qextra", font:"Courier New") 를 더한 값으로 정의되거나, #text("qtotal", font:"Courier New") 이 이보다 클 경우 #text("qtotal", font:"Courier New") 로 정의된다. 일반적으로 #text("qtotal", font:"Courier New") 은 S/P 진폭비의 총 개수에 평균 불확실성 추정치를 곱한 값이며, #text("qextra", font:"Courier New")는 #text("qtotal", font:"Courier New") 의 절반을 가진다.
 - #text("dang", font:"Courier New") 은 격자 검색법의 정밀도를 나타내는 매개변수이며, #text("maxout", font:"Courier New") 은 출력되는 허용 가능한 단층면해들의 최대 개수를 설정하는 매개변수이다.
 - 계산으로부터 얻어낸 허용 가능한 단층면해들의 총 개수는 #text("nf", font:"Courier New") 로 표시되며, 최대 개수는 #text("maxout", font:"Courier New") 으로 제한되어진다. 최종적으로, 각각의 허용 가능한 단층면해에 대해 단층면해에 연관된 매개변수와 두 Nodal plane의 법선 벡터가 출력된다.
 - #text("FOCALMC", font:"Courier New") 은 P파의 초동 극성만을 이용하여 단층면해를 계산하는 서브루틴이다.
  #block(fill: luma(230), inset: 8pt, radius: 4pt, [```Fortran
    subroutine FOCALMC(p_azi_mc, p_the_mc, p_pol, p_qual, npsta, nmc, dang, maxout, nextra, ntotal, nf, strike, 
                       dip, rake, faults, slips)```
  - Inputs
   #list(marker: ([•]),
  [#text("p_azi_mc(npsta, nmc)", font:"Courier New") : 방위각],
  [#text("p_the_mc(npsta, nmc)", font:"Courier New") : 출발각],
  [#text("p_pol(npsta)", font:"Courier New") : P파의 초동 극성(1 = up, -1 = down)],
  [#text("p_qual(npsta)", font:"Courier New") : P파의 초동 품질(0 = 펄스 신호, 1 = 점진적)],
  [#text("npsta", font:"Courier New") : 관측한 P파 초동의 수],
  [#text("nmc", font:"Courier New") : 각 관측소에서 가능한 방위각-출발각 조합의 수로, 계산의 횟수를 의미],
  [#text("dang", font:"Courier New") : 격자 검색법에서의 각도 간격(Degree)],
  [#text("maxout", font:"Courier New") : 출력되는 단층 면의 최대 개수로, 값을 초과할 경우 그 중 랜덤한 값이 출력],
  [#text("nextra", font:"Courier New") : 추가된 극성 오차의 수],
  [#text("ntotal", font:"Courier New") : 허용 가능한 극성 오차의 최소 개수])
  - Outputs
   #list(marker: ([•]),
   [#text("nf", font:"Courier New") : 계산된 단층면해의 수],
   [#text("strike(min(maxout, nf))", font:"Courier New") : 주향],
   [#text("dip(min(maxout, nf))", font:"Courier New") : 경사],
   [#text("rake(min(maxout, nf))", font:"Courier New") : 미끌림각],
   [#text("faults(3, min(maxout, nf))", font:"Courier New") : 단층면의 법선 벡터],
   [#text("slips(3, min(maxout, nf))", font:"Courier New") : 단층의 미끄러짐(Slip) 벡터],
   )])
 - #text("FOCALAMP_MC", font:"Courier New") 은 P파의 초동 극성과 S/P 진폭비를 모두 이용하여 단층면해를 계산하는 서브루틴이다.
  #block(fill: luma(230), inset: 8pt, radius: 4pt, [```Fortran
    subroutine FOCALAMP_MC(p_azi_mc, p_the_mc, sp_amp, p_pol, npsta, nmc, dang, maxout, nextra, ntotal, qextra, 
                           qtotal, nf, strike, dip, rake, faults, slips)
    ```
  - Inputs
   #list(marker: ([•]),
  [#text("p_azi_mc(npsta, nmc)", font:"Courier New") : 방위각],
  [#text("p_the_mc(npsta, nmc)", font:"Courier New") : 출발각],
  [#text("sp_amp(npsta)", font:"Courier New") : S/P 진폭비($log_10 ("S/P")$)],
  [#text("p_pol(npsta)", font:"Courier New") : P파의 초동 극성(1 = up, -1 = down)],
  [#text("npsta",font:"Courier New") : 관측한 P파 초동의 수],
  [#text("nmc",font:"Courier New") : 각 관측소에서 가능한 방위각-출발각 조합의 수로, 계산의 횟수를 의미],
  [#text("dang",font:"Courier New") : 격자 검색법에서의 각도 간격(Degree)],
  [#text("maxout",font:"Courier New") : 출력되는 단층 면의 최대 개수로, 값을 초과할 경우 그 중 랜덤한 값이 출력],
  [#text("nextra",font:"Courier New") : 추가된 극성 오차의 수],
  [#text("ntotal",font:"Courier New") : 허용 가능한 극성 오차의 최소 개수],
  [#text("qextra",font:"Courier New") : 추가된 진폭  오차의 최소 개수],
  [#text("qtotal",font:"Courier New") : 허용 가능한 진폭 오차의 최소 개수],
  )
  - Outputs
   #list(marker: ([•]),
   [#text("nf", font:"Courier New") : 계산된 단층면해의 수],
   [#text("strike(min(maxout, nf)", font:"Courier New")) : 주향],
   [#text("dip(min(maxout, nf)", font:"Courier New")) : 경사],
   [#text("rake(min(maxout, nf)", font:"Courier New")) : 미끌림각],
   [#text("faults(3, min(maxout, nf)", font:"Courier New")) : 단층면의 법선 벡터],
   [#text("slips(3, min(maxout, nf)", font:"Courier New")) : 단층의 미끄러짐(Slip) 벡터],
   )])
- 최적의 단층면해 계산
 - 계산으로부터 얻은 단층면해들은 최적의 단층면해 및 해의 품질 추정치를 결정하는데에 사용되며, 최적의 단층면해는 이상치들을 제거한 이후의 허용 가능한 단층면해들의 평균으로부터 얻을 수 있다. 또한 두 가지의 불확실성이 계산될 수 있는데, 허용 가능한 nodal plane과 최적의 nodal plane 사이의 RMS 차이와, 사용자가 정의한 '가까운' 각도를 기준으로 최적의 단층면해가 실제 단층면해와 '가까울' 확률로 나타낼 수 있다. 만약 이상치가 군집의 형태를 가지고 나타난다면, 이 이상치를 기반으로 단층면해의 대안을 찾을 수 있다. 사용자는 이 대안들에 대해 최소 확률을 설정할 수 있어, 낮은 확률을 가지는 해는 무시할 수 있다.
  #block(fill: luma(230), inset: 8pt, radius: 4pt,
  [```Fortran
    subroutine MECH_PROB(nf, normlin, norm2in, cangle, str_avg, dip_avg, rak_avg, prob, rms_diff)
    ```
  - Inputs
   #list(marker: ([•]),
  [#text("nf", font :"Courier New") : 단층면의 수 ],
  [#text("norm1(3,nf)" ,font :"Courier New") : 단층면의 법선 벡터],
  [#text("norm2(3,nf)",font :"Courier New") : 단층의 미끄러짐(Slip) 벡터],
  [#text("cangle",font :"Courier New") : cangle 보다 작은 각도를 가질 때, 단층면해가 실제 단층면해와 '가깝다'고 여길 수 있음],
  [#text("prob_max", font :"Courier New") : 대안 해들에 대한 최소(차단)) 확률])
  - Outputs
   #list(marker: ([•]),
  [#text("nstln", font :"Courier New") : 출력되는 해의 개수],
  [#text("str_avg(nstln)", font :"Courier New") : 각 단층면해의 주향],
  [#text("dip_avg(nstln)", font :"Courier New") : 각 단층면해의 경사],
  [#text("rak_avg(nstln)", font :"Courier New") : 각 단층면해의 미끌림각],
  [#text("prob(nstln)", font :"Courier New") : 최적의 단층면해가 실제 단층면해와 '가까울' 확률],
  [#text("rms_diff(2,nstln)", font :"Courier New") : 허용 가능한 nodal plane과 최적의 nodal plane 사이의 RMS 차이(1 = 주단층면, 2 = 보조단층면)])])
- 최적의 단층면해에 대한 데이터 오차 계산
 - 단층면해를 계산의 마지막 과정은 최적의 단층면에 대한 데이터의 오차를 찾는 것이다. 계산 과정에 S/P 진폭비를 P파의 초동 극성과 함께 사용할 것인지 여부에 따라 별개의 유사한 서브루틴이 사용될 수 있다. 입력 데이터로는 관측소 별 P파의 초동 극성(과 S/P 진폭비), 방위각, 출발각(이전 과정과 달리 최적의 조합 하나만을 사용)과 최적의 단층면해를 이용한다. 출력되는 데이터는 초동 극성의 가중 오차 #text("mfrac", font: "Courier New"), 관측소 분포비 #text("stdr", font: "Courier New") 이다. 만약 S/P 진폭비가 사용된다면, 계산된 평균 $log_10 ("S/P")$ 오차가 #text("mavg", font: "Courier New") 로 출력되어진다.
 - #text("GET_MISF", font:"Courier New") 은 P파의 초동 극성만을 이용하여 오차를 계산하는 서브루틴이다.
  #block(fill: luma(230), inset: 8pt, radius: 4pt,
  [```Fortran
    subroutine GET_MISF(npol, p_azi_mc, p_the_mc, p_pol, p_qual, str_avg, dip_avg, rak_avg, mfrac, stdr)
    ```
  - Inputs
   #list(marker: ([•]),
  [#text("npol", font:"Courier New") : 관측한 P파 초동 극성의 수],
  [#text("p_azi_mc(npol)", font:"Courier New") : 방위각],
  [#text("p_the_mc(npol)", font:"Courier New") : 출발각],
  [#text("p_pol(npol)", font:"Courier New") : P파의 초동 극성],
  [#text("p_qual(npol)", font:"Courier New") : P파의 초동 품질],
  [#text("str_avg, dip_avg, rak_avg", font:"Courier New") : 최적의 메커니즘],)
  - Outputs
   #list(marker: ([•]),
  [#text("mfrac", font:"Courier New") : 초동 극성의 가중 오차],
  [#text("stdr", font:"Courier New") : 관측소 분포비],)
   ])
 - #text("GET_MISF_AMP", font:"Courier New") 은 P파의 초동 극성과 S/P 진폭비를 모두 이용하여 오차를 계산하는 서브루틴이다.
 #block(fill: luma(230), inset: 8pt, radius: 4pt,
  [```Fortran
    subroutine GET_MISF_AMP(npol, p_azi_mc, p_the_mc, sp_ratio, p_pol, str_avg, dip_avg, rak_avg, mfrac, mavg, stdr)
    ```
  - Inputs
   #list(marker: ([•]),
  [#text("npol", font:"Courier New") : 관측한 P파 초동 극성의 개수],
  [#text("p_azi_mc(npol)", font:"Courier New") : 방위각],
  [#text("p_the_mc(npol)", font:"Courier New") : 출발각],
  [#text("sp_ratio(npol)", font:"Courier New") : S/P 진폭비],
  [#text("p_pol(npol)", font:"Courier New") : P파의 초동 극성],
  [#text("str_avg, dip_avg, rak_avg", font:"Courier New") : 최적의 메커니즘],)
  - Outputs
   #list(marker: ([•]),
  [#text("mfrac", font:"Courier New") : 초동 극성의 가중 오차],
  [#text("mavg", font:"Courier New") : 평균 $log_10 ("S/P")$ 오차],
  [#text("stdr", font:"Courier New") : 관측소 분포비],)])
#pagebreak()
== Input and Data Preparation:
- 입력 데이터 준비
 - 앞서 언급했듯이, 사용자의 입력 데이터를 내부 배열로 불러올 때, 데이터의 형식 등을 고려하여 최대한 효율적으로 불러오는 것을 권장한다. 데이터를 불러오는 방법을 설명하기 위해 이와 관련한 예제 드라이버 프로그램들을 포함하였다. 해당 예시들은 여기#footnote[Hardebeck & Shearer (2002), Shearer et al. (2003), Hardebeck & Shearer (2003)] 에서 논의된 Northridge, California의 비슷한 이벤트 군집 데이터를 사용한다.
 - 사용자는 가지고 있는 데이터의 형식에 맞춰 후술할 예제들을 수정할 수 있다. 관측소 위치 / 초동 극성 입력 데이터의 형식(주석 처리)에 맞춰 가지고 있는 데이터의 형식을 바꿔야 할 수 있으며, 또한 가지고 있는 관측소 정보의 형식과 일치시키기 위해 station_subs.f 내의 #text("GETSTAT_TRI, CHECK_POL", font:"Courier New") 서브루틴을 수정해야 할 수도 있다. 이 서브루틴의 기본 개념은 두 개의 테이블(Look-up table)을 사용하는 것으로, 하나는 주어진 관측소의 위치를, 다른 하나는 알려진 초동 극성의 반전을 확인하기 위한 테이블이다. 또한 관측소를 알파벳 순서로 정렬하는 것은 검색 속도를 더욱 빠르게 하는데 도움이 될 수 있다.
- 예제 1
 - 예제 1은 각 관측소까지의 방위각과 출발각이 이미 계산되었고, 이들의 불확실성까지 이미 추정한 상황을 가정한다. 입력 데이터(north1.phase)는 수정된 표준 FPFIT 형식을 따라 방위각과 출발각의 불확실성을 포함하게끔 확장되었고, 데이터 대부분을 배열로 직접 읽을 수 있다. 각 계산에 대한 방위각과 출발각은 주어진 평균값과 표준편차 기반의 정규분포에서 임의의 값을 선택하여 계산된다.
 - 일부 관측소에서는 특정 기간 동안 초동의 극성이 반전된 것으로 알려져 있기 때문에, #text("CHECK_POL", font:"Courier New") 서브루틴을 호출하여 지진이 발생한 시점의 각 관측소에서 초동의 극성 반전 여부를 확인한다. 관련된 입력 데이터(scsn.reverse)는 표준 FPFIT 형식과 일치한다.
 - 예제 1은 몇 가지 매개변수를 읽어오며, #text("dang, nmc, maxout, cangle", font:"Courier New") 매개변수는 단층면해 계산 서브루틴에 직접 전달되어 앞서 설명한 대로 적용된다. 매개변수 #text("badfrac", font:"Courier New") 은 데이터셋이 가지는 (펄스)초동 극성의 오차 비율에 대한 사용자의 추정치로, 이를 바탕으로 #text("nextra, ntotal", font:"Courier New") 이 계산되어진다.
 - 입력 배열에 포함될 데이터를 선택하는데에도 추가적인 매개변수가 필요하다. 진원-관측소 간 최대 거리를 의미하는 매개변수 #text("delmax", font:"Courier New"), 필요한 초동 극성의 최소 개수 #text("npolmin", font:"Courier New"), 방위각 및 출발각에서 허용 가능한 최대 데이터 공백은 각각 #text("max_agap, max_pgam", font:"Courier New") 등이 있다. #text("max_agap, max_pgam", font:"Courier New") 를 충족하지 못하는 지진에 대해서는 단층면해를 계산할 수 없다.
- 예제 2
 - 예제 2는 방위각과 출발각의 불확실성을 잘 알지 못하는 상황을 가정한다. 먼저 신뢰할 만한 속도 구조모델을 기반으로 출발각을 계산하기 위해 1차원 지진파 파선 트레이싱 루틴이 사용된다(관측소의 방위각은 모든 1차원 속도 구조모델에서 동일). 서로 다른 속도 구조모델 및 진원의 깊이를 바꾸어가며 각각의 계산이 수행되며, 결과적으로 계산된 출발각들을 얻을 수 있다.   
 - 입력 데이터 중 P파의 초동 극성(north2.phase)은 FPFIT 형식과 유사한 형식을 가진다. 관측소에서의 방위각과 출발각을 계산해야 하기 때문에 관측소의 이름과 위치가 포함된 입력 데이터(scsn.station) 역시 필요로 하며, #text("GETSTAT_TRI", font:"Courier New") 서브루틴은 관측소의 위치를 조회하는 데 사용된다.
 - 또한 속도 구조모델(vz.socal 등)을 읽어와야 하며, #text("MK_TABLE", font:"Courier New") 서브루틴을 호출함으로써 출발각 테이블들을 생성할 수 있다. 특정한 진원-관측소 간 거리와 진원 깊이에 따른 출발각은 #text("GET_TTS", font:"Courier New") 서브루틴을 호출함으로써 얻을 수 있다. 해당 서브루틴의 첫 번째 인수에는 사용할 1차원 속도 구조모델이 들어간다.
- 예제 3
 - 예제 3은 P파의 초동 극성 뿐 아니라 S/P파의 진폭비를 이용해 단층면해를 계산한다. 입력 데이터(north3.amp)는 P파와 S파의 진폭, P파와 S파 도달 전 잡음의 수준이 포함되어야 한다. 또한 $log_10 ("S/P")$#footnote[Hardeback & Shearer (2003)] 에 대해 보정값을 적용해 관측소 보정을 수행하기 때문에, 이 보정값이 포함된 입력 데이터(north3.statcor)를 필요로 한다.
 - 예제 3은 추가적인 두 매개변수를 필요로 한다. 먼저 #text("ratmin", font:"Courier New") 은 신호 대 잡음비 수준의 기준을 정의하는 변수로, 예제는 신호 대 잡음비가 최소 #text("ratmin", font:"Courier New") 이상인 파형으로부터만 S/P 진폭비를 이용한다. #text("qbadfrac", font:"Courier New") 은 $log_10 ("S/P")$ 의 불확실성 추정치로, 이를 이용해 허용 가능한 $log_10 ("S/P")$ 의 오차(#text("qextra, qtotal", font:"Courier New") 를 추정할 수 있다. 각 지진이 가지는 ID는 서로 다른 파일에서 P파의 초동 극성과 S/P 진폭비를 일치시키는 데 사용되기 때문에, 해당 예제에서는 지진이 고유한 ID를 가지는 것이 매우 중요하다.
- 예제 4
 - (새로 추가) 최신의 SCEDC 형식으로 업데이트된 예제이며, 다섯 글자 길이의 관측소 이름을 포함한다. 
- 예제 5
 - (새로 추가) SIMULPS#footnote[Evans et al. (1994)] 프로그램의 출력을 이용한 예시로, 방위각과 출발각을 얻어 3차원 속도 구조모델에서 지진파의 파선 트레이싱을 통해 단층면해를 계산할 수 있다.
#pagebreak()
== Include Files:
- Include files
 - param.inc는 입출력 배열의 최대 크기를 지정하는데 사용되는 파일이다.
  #block(fill: luma(230), inset: 8pt, radius: 4pt,
  list(marker:([•]),
  [#text("npick0", font:"Courier New") : 지진별 지진파 위상의 최대 개수],
  [#text("nmc0", font:"Courier New") : 진원 위치 / 출발각 계산의 최대 횟수],
  [#text("nmax0", font:"Courier New") : 출력되는 허용 가능한 단층면해의 최대 개수]))
 - rot.inc는 격자의 최소 각도 크기를 설정하며, 그에 대응하는 격자점의 최대 개수 및 테스트 단층면해의 개수를 지정한다(격자점의 최대 개수와 단층면해의 최대 개수는 함께 변경해야 함). 
  #block(fill: luma(230), inset: 8pt, radius: 4pt,
  list(marker:([•]),
  [#text("dang0", font:"Courier New") : 최소 격자 간격(degree)],
  [#text("ncoor", font:"Courier New") : 테스트 단층면해의 수]))
 - vel.inc는 1차원 속도 구조모델이 사용되었을 경우 그에 관한 매개변수를 지정하는 파일이다.
  #block(fill: luma(230), inset: 8pt, radius: 4pt,
  list(marker:([•]),
  [#text("nx0", font:"Courier New") : 테이블 행의 최대 수],
  [#text("nd0", font:"Courier New") : 테이블 열의 최대 수],
  [#text("nindex", font:"Courier New") : 1차원 속도 구조모델 / 테이블의 최대 수],
  [#text("dep1", font:"Courier New") : 최소 진원 깊이 ],
  [#text("dep2", font:"Courier New") : 최대 진원 깊이 ],
  [#text("dep3", font:"Courier New") : 테이블의 진원 깊이 간격(km, [$"dep2" - "dep1" "/" "dep3" + 1 <= "nd0"$])],
  [#text("del1", font:"Courier New") : 최소 진원-관측소 거리(km) ],
  [#text("del2", font:"Courier New") : 최대 진원-관측소 거리(km) ],
  [#text("del3", font:"Courier New") : 테이블의 진원-관측소 거리 간격(km, [$"del2" - "del1" "/" "del3" + 1 <= "nx0"$] ],
  [#text("pmin", font:"Courier New") : 파선 변수의 최소값 ],
  [#text("nump", font:"Courier New") : 트레이싱된 파선의 개수 ]))
#pagebreak()
== Output:
- Output
 - 출력 형식은 사용자의 필요에 맞게 변경할 수 있다. 앞선 예제들에서는 일반적으로 두 개의 출력 파일을 생성한다. 하나는 각 지진에 대해 최적의 단층면해를 한 줄로 기록한 파일이며, 다른 하나는 각 지진에 대해 허용 가능한 모든 단층면해의 목록을 기록한 파일이다. 또한 우리는 다음과 같은 단층면해의 품질을 결정하는 기준을 개발하였고, 사용자의 기준에 맞추어 새로운 기준을 개발하는 것도 가능하다. 초기의 테스트#footnote[Kilb & Hardebeck, (2005)] 에 의하면, 단층면해의 품질을 결정하는 가장 좋은 단일 지표는 단층면의 불확실성으로부터 평균 RMS($0.5 times (text("rms_diff", font:"Courier New")(1) + text("rms_diff", font:"Courier New")(2))$)을 구하는 것으로, 이 값이 35° 이하일 때 최적의 단층면해임을 의미한다.
#set table(
    stroke: (x, y) => if y == 0 {
      (bottom: 1pt + black)},
      align: (x, y) => (center))
#figure(
  table(
  columns: 5,
  [품질(#text("qual", font:"Courier New"))],[평균 오차(#text("mfrac", font:"Courier New"))],[단층면 불확실성 RMS],[관측소 분포비(#text("stdr", font:"Courier New"))],[단층면해 확률(#text("prob", font:"Courier New"))],
  [A],[$<= 0.15$],[$<= 25°$],[$>= 0.5$],[$>= 0.8$],
  [B],[$<= 0.20$],[$<= 35°$],[$>= 0.4$],[$>= 0.6$],
  [C],[$<= 0.30$],[$<= 45°$],[$>= 0.3$],[$>= 0.7$],
  [D],table.cell(colspan: 4)[최대 방위각 간격 ≤ 90°, 최대 출발각 간격 ≤ 60°],
  [E],table.cell(colspan: 4)[최대 방위각 간격 > 90°, 최대 출발각 간격 > 60°],
  [F],table.cell(colspan: 4)[8개 미만의 초동 극성]))
#pagebreak()
= FILE FORMATS
- 파일 형식
 - 예제에서 사용된 입출력 파일 형식으로, 사용자의 파일 형식이 다르다면 형식 변환 루틴을 작성하는 대신 드라이버 코드를 수정하여 파일 형식에 일치하도록 하는 것이 바람직하다.
== Input Files
=== P-polarity Files:
- 예제 1: north1.phase
#figure(
  grid(columns : (auto, auto),
  rows : (auto),
  gutter : 5em,
 [- Event lines:
  #table(
    columns: 3,
    [열],[형식],[값],
    [1-10],[5i2],[진원시(연, 월, 일, 시, 분)],
    [11-14],[f4.2],[진원시(초)],
    [15-16],[i2],[위도(도)],
    [17],[a1],[위도(N, S)],
    [18-21],[f4.2],[위도(분)],
    [22-24],[i3],[경도(도)],
    [25],[a1],[경도(W, E)],
    [26-29],[f4.2],[경도(분)],
    [30-34],[f5.2],[진원 깊이(km)],
    [35-36],[f2.1],[규모],
    [81-88],[2f4.2],[수평, 수직 불확실성(km)],
    [123-138],[a16],[이벤트 ID])],
 [- Polarity lines:
  #table(
    columns: 3,
    [열],[형식],[값],
    [1-4],[a4],[관측소 이름],
    [7],[a1],[초동(U, u, +, D, d, -)],
    [8],[i1],[초동 품질(0, 1, 2..)],
    [59-62],[f4.1],[진원-관측소 거리(km)],
    [66-68],[i3],[출발각],
    [79-81],[i3],[방위각],
    [83-85],[i3],[출발각 불확실성],
    [87-89],[i3],[방위각 불확실성])]))
- 예제 2: north2.phase
#figure(
  grid(columns : (auto, auto),
  rows : (auto),
  gutter : 5em,
 [- Event lines:
  #table(
    columns: 3,
    [열],[형식],[값],
    [1-4],[i4],[진원시(연)],
    [5-12],[4i2],[진원시(월, 일, 시, 분)],
    [13-17],[f5.2],[진원시(초)],
    [18-19],[i2],[위도(도)],
    [20],[a1],[위도(N, S)],
    [21-25],[f5.2],[위도(분)],
    [26-28],[i3],[경도(도)],
    [29],[a1],[경도(N, S)],
    [30-34],[f5.2],[경도(분)],
    [35-39],[f5.2],[진원 깊이],
    [89-93],[f5.2],[수평 진원 위치 불확실성(km)],
    [95-99],[f5.2],[수직 진원 위치 불확실성(km)],
    [140-143],[f4.2],[규모],
    [150-165],[a16],[이벤트 ID])],
 [- Polarity lines:
  #table(
    columns: 3,
    [열],[형식],[값],
    [1-4],[a4],[관측소 이름],
    [6-7],[a2],[관측소 네트워크],
    [10-12],[a3],[관측소 채널],
    [14],[a1],[초동(I, E)],
    [16],[a1],[초동(U, u, +, D, d, -)])]))
#pagebreak()
- 예제 4: north4.phase
#figure(
  grid(columns : (auto, auto),
  rows : (auto),
  gutter : 5em,
 [- Event lines:
  #table(
    columns: 3,
    [열],[형식],[값],
    [1-4],[i4],[진원시(연)],
    [5-12],[4i2],[진원시(월, 일, 시, 분)],
    [13-16],[f4.2],[진원시(초)],
    [17-18],[i2],[위도(도)],
    [19],[a1],[위도(N, S)],
    [20-23],[f4.2],[위도(분)],
    [24-26],[i3],[경도(도)],
    [27],[a1],[경도(N, S)],
    [28-31],[f4.2],[경도(분)],
    [32-36],[f5.2],[진원 깊이(km)],
    [131-146],[a16],[이벤트 ID],
    [148-150],[f3.2],[규모])],
 [- Polarity lines:
  #table(
    columns: 3,
    [열],[형식],[값],
    [1-5],[a5],[관측소 이름],
    [6-7],[a2],[관측소 네트워크],
    [10-12],[a3],[관측소 채널],
    [14],[a1],[초동(i, I, e, E)],
    [16],[a1],[초동(U, u, +, D, d, -)])]))
=== S/P Amplitude Files:
- 예제 3: north3.amp
#figure(
  grid(columns : (auto, auto),
  rows : (auto),
  gutter : 5em,
 [- Event lines(자유 형식) \ \  이벤트 ID #h(1em) 관측 수],
 [- Amplitude lines:
  #table(
    columns: 3,
    [열],[형식],[값],
    [1-4],[a4],[관측소 이름],
    [6-8],[a3],[관측소 네트워크],
    [10-11],[a2],[관측소 채널],
    [29-38],[f10.3],[P파 도달 전 잡음 수준],
    [40-49],[f10.3],[P파 진폭(임의의 단위)],
    [51-60],[f10.3],[S파 도달 전 잡음 수준],
    [62-71],[f10.3],[S파 진폭(임의의 단위)])]))
=== SIMULPS 3D ray-tracing Files:
- 예제 5: north5.simulps
#figure(
  grid(columns : (auto, auto),
  rows : (auto),
  gutter : 5em,
 [- Event lines:
  #table(
    columns: 3,
    [열],[형식],[값],
    [2-7],[3i2],[진원시(연, 월, 일)],
    [9-12],[2i2],[진원시(시, 분)],
    [14-18],[f5.2],[진원시(초)],
    [20-21],[i2],[위도(도)],
    [22],[a1],[위도(N, S)],
    [23-27],[f5.2],[위도(분)],
    [29-31],[i3],[경도(도)],
    [32],[a1],[경도(N, S)],
    [33-37],[f5.2],[경도(분)],
    [39-44],[f6.2],[진원 깊이(km)],
    [48-51],[f4.2],[규모],
    [56-63],[a8],[이벤트 ID])],
 [- Station lines:
  #table(
    columns: 3,
    [열],[형식],[값],
    [2-5],[a4],[관측소 이름],
    [7-11],[f5.1],[진원 거리],
    [12-15],[i4],[방위각],
    [16-19],[i4],[출발각],
    [66-69],[f4.0],[방위각 불확실성],
    [70-73],[f4.0],[출발각 불확실성])]))
=== Velocity Model Files:
- Velocity files(자유 형식)
 - 진원 깊이(km) #h(1em) P파 속도(km/s)
=== Station Files:
- Station files: 모든 관측소는 알파벳 순서로 정렬되어야 한다.
#figure(
  grid(columns : (auto, auto),
  rows : (auto),
  gutter : 5em,
 [- 예제 1, 2, 3, 5: station_subs.f; scsn.stations
  #table(
    columns: 3,
    [열],[형식],[값],
    [1-4],[a4],[관측소 이름],
    [6-8],[a3],[관측소 채널],
    [42-50],[f9.5],[관측소 위도(도)],
    [52-61],[f10.5],[관측소 경도(도)],
    [63-67],[i5],[관측소 고도(m)],
    [91-92],[a2],[네트워크 코드])],
  [- 예제 4: station_subs_5char.f; scsn.stations_5char
  #table(
    columns: 3,
    [열],[형식],[값],
    [1-2],[a2],[네트워크 코드],
    [5-9],[a5],[관측소 이름],
    [11-13],[a3],[관측소 채널],
    [61-69],[f9.5],[관측소 위도(도)],
    [71-80],[f10.5],[관측소 경도(도)],
    [82-86],[i5],[관측소 고도(m)])],
  [- 초동 극성 반전 파일
  #table(
    columns: 3,
    [열],[형식],[값],
    [1-4(5)],[a4(5)],[관측소 이름],
    [6-9],[i4],[초동 극성 반전 시작(연)],
    [10-11],[i2],[초동 극성 반전 시작(월)],
    [12-13],[i2],[초동 극성 반전 시작(일)],
    [15-18],[i4],[초동 극성 반전 종료(연)],
    [19-20],[i2],[초동 극성 반전 종료(월)],
    [21-22],[i2],[초동 극성 반전 종료(일)])]))
#pagebreak()
== Output Files
- Output file 1: 최적의 단층면해(지진별 한 줄)
#figure(
  grid(columns : (auto, auto),
  rows : (auto),
  gutter : 5em,
 [#table(
    columns: 3,
    [열],[형식],[값],
    [1-16],[a16],[],
    [18-21],[i4],[진원시(연)],
    [23-24],[i2],[진원시(월)],
    [26-27],[i2],[진원시(일)],
    [29-30],[i2],[진원시(시)],
    [32-33],[i2],[진원시(분)],
    [35-40],[f6.3],[진원시(초)],
    [42],[a1],[지진 종류()],
    [44-48],[f5.3],[규모],
    [50],[a1],[규모 종류()],
    [52-60],[f9.5],[진원 위도(도)],
    [62-71],[f10.5],[진원 경도(도)],
    [73-79],[f7.3],[진원 깊이(km)],
    [81],[a1],[진원 품질()],
    [83-89],[f7.3],[RMS],
    [91-97],[f7.3],[수평 오차(km)],
    [99-105],[f7.3],[깊이 오차(km)],
    [107-113],[f7.3],[진원시 오차(초)],
    [117-120],[i4],[진원 결정에 사용된 위상의 수],
    [122-125],[i4],[P파 위상의 수],
    [127-130],[i4],[S파 위상의 수],
    [132-135],[i4],[단층면해 주향(도)],
    [137-139],[i3],[단층면해 경사(도)],
    [141-144],[i4],[단층면해 미끌림각(도)],
    [148-149],[i2],[단층면 불확실성(도)],
    [151-152],[i2],[보조 단층면 불확실성(도)],
    [154-156],[i3],[P파 초동극성의 수],
    [158-159],[i2],[],
    [161],[a1],[단층면해 품질],
    [163-165],[i3],[],
    [167-168],[i2],[],
    [170-172],[i3],[S/P 진폭비의 수],
    [174-176],[i3],[100$times$평균 $log("S/P")$ 오차],
    [178],[a1],[Multiple flag])]))
#pagebreak()
- Output file 2: 허용 가능한 단층면해들(지진별 여러 줄)
#figure(
  grid(columns : (auto, auto),
  rows : (auto),
  gutter : 5em,
 [- Event lines
  #table(
    columns: 3,
    [열],[형식],[값],
    [1-16],[a16],[이벤트 이름],
    [18-21],[i4],[진원시(연)],
    [23-24],[i2],[진원시(월)],
    [26-27],[i2],[진원시(일)],
    [29-30],[i2],[진원시(시)],
    [32-33],[i2],[진원시(분)],
    [35-40],[f6.3],[진원시(초)],
    [42],[a1],[지진 종류()],
    [44-48],[f5.3],[규모],
    [50],[a1],[규모 종류],
    [52-60],[f9.5],[진원 위도],
    [62-71],[f10.5],[진원 경도],
    [73-79],[f7.3],[진원 깊이],
    [81],[a1],[진원 품질],
    [83-89],[f7.3],[],
    [91-97],[f7.3],[],
    [99-105],[f7.3],[])],
  [- Mechanism lines
  #table(
    columns: 3,
    [열],[형식],[값],
    [1-16],[a16],[],
    [18-21],[i4],[진원시(연)],
    [23-24],[i2],[진원시(월)],
    [26-27],[i2],[진원시(일)],
    [29-30],[i2],[진원시(시)],
    [32-33],[i2],[진원시(분)],
    [35-40],[f6.3],[진원시(초)],
    [42],[a1],[지진 종류()],
    [44-48],[f5.3],[규모],
    [50],[a1],[규모 종류],
    [52-60],[f9.5],[진원 위도])]))


















