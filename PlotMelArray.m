% PlotMelArray.m 
% A fun function to plot the Mel Wrap, this is also called in the Methods
% of WavFileObj

function PlotMelArray(MelWrapArray)
    figure;
    imagesc(MelWrapArray)
    colorbar;
    xlabel('Frames');
    ylabel('Mel Bins');
    title('Mel Wrap plotted with Flipped Frequency Axis');
end