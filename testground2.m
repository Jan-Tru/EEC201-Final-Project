

num = 1;
test_objs = LoadMassFiles("test",num);

object = test_objs{1};
% col5 = object.MelWrapArray(:,5);

% stem(col5)
% title("Response after applying Mel Frequency Banks Triangular Bins")
% xlabel("Mapped frequency bins 20 = Sample Rate / 2")
% ylabel("Magnitdue of the summation of FFT samples within a Mel Filter Bin")