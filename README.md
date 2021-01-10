# M1F_Biomedical-Signal-Processing

## Homework 1
* ### Problem 1  
  A noisy ECG signal is provided in the file ecg_hfn.dat. 
  (See also the file ecg_hfn.m)
  The sampling rate of this signal is 1000 Hz
  Develop a MATLAB program to perform synchronized averaging as described in Section 3.3.1. 
  Select a QRS complex from the signal for use as the template and use a suitable threshold on the cross-correlation function in Equation 3.18 for beat detection.
  Plot the resulting averaged QRS complex. Ensure that the averaged result covers one full cardiac cycle. Plog a sample ECG cycle from the noisy signal for comparison.
  Observe the results when the threshold on the cross-correlation function is low or high.
* ### Problem 2  
  Average the ECG signal by 2 and 4 points, plot the waveforms and discuss the results.
  
Due date : PPT report 10 / 22 2020
  
## Homework 2
* ### Problem 1  
  * Show the ACF of the 4.2~4.96 s segments of f3 and o1 channels (eeg1-f3.dat, eeg1-o1.dat)
  * Show Crosscorrelation of o1 and o2 during 4.72~5.71 secs (eeg1)
  * Show Crosscorrelation of o1 and f3 during 4.72~5.71 secs (eeg1)
* ### Problem 2
  * Apply three-point central-difference operator to the ECG with low-frequency noise (fs=1000 Hz)
  * Calculate the noise levels of ECGs before and after filtering.
  * Calculate bpm of the ECG signal  
  
Reference : Biomedical Signal Analysis , Rangaraj M . Rangayyan , Wiley  
Due date : 11 / 05 , 2020 

## Homework 3
3.13 LABORATORY EXERCISES AND PROJECTS
* Design a Wiener filter to remove the artifacts in the ECG signal in the file ecg_hfn.dat.
  (See also the file ecg-hfn.m.) The equation of the desired filter is given in Equation 3.101. 
  The required model PSDs may be obtained as follows:
Create a piece-wise linear model of the desired version of the signal by concatenate linear segments to provide P QRS, 
  and T waves with amplitudes, durations, and intervals similar to those in the given noisy ECG signal. 
  Compute the PSD of the model signal.
* Redo the above exp by using the ECG filtered by the Comb filter as the template.
* Also Compare the results with the results of the lowpass filter.

Due date of PPT report : 11 / 11 2020

## Homework 4
1. Implement the Pan-Tompkins method for QRS detection in MATLAB. 
   You may employ a simple threshold-based method to detect QRS complexes as the procedure will be run off-line.  
   Apply the procedure to the signals in the files ECG3.dat, ECG4.dat, ECG5.dat, and ECG6.dat, sampled at a rate of 200 Hz 
   (see the file ECGS.m). Compute the averaged heart rate and QRS width for each record. 
   Verify your results by measuring the parameters visually from plots of the signals.
2. Implement the adaptive thresholding and searchback procedure to your P-T method and redo problem 1.
3. Apply your P-T method to your personal ECG.

Due date : 11 / 26 2020

## Homework 5
* ### Problem 1
  * 利用 PCA 分析 EEG2 10 channel 之 EEG data.
  * 分析 EEG 各 channel 之 covariance matrix，及 10 個 PC 之 covariance matrix。
  * 需要多少個 PC 才能包含 85% 的 variance?
  * 說明觀察之心得
* ### Problem 2
  同 problem 1, 分析 EEG 1 data.
* ### Problem 3
  觀察 eigenvector 係數與 channel 間的關係

Due date : 12 / 24 , 2020
