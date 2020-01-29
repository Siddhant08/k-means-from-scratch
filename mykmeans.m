function [C,V] = mykmeans(Data,k)
    %function to implement k-means clustering algorithm
    
    %load data
    load (Data);
    
    %random initialization of centroids
    random_index=randi([1,length(Data)],k,1);
    centroids=[Data(random_index,1),Data(random_index,2)];
    
    %run loop until the centroids stop changing
    iterCount=0;
    while(true)
        
        %for stopping criterion
        prevCentroid=centroids;
    
        %compute euclidean distances
        dist=pdist2(centroids,Data);

        %assign centroid to point - change name to cluster_label
        centroid_label=(1:3000);
        for i=1:length(Data)
            [~,idx]=sort(dist(:,i));
            centroid_label(i)=idx(1);        
        end
        
        %update centroids
        for i=1:k
            centroids(i,:)=mean(Data(centroid_label==i,:));   
        end
        
        %count iterations
        iterCount=iterCount+1;
        
        %check for stopping criterion
        if prevCentroid==centroids
            disp('centroids found!')
            sprintf('Total iterations: %d',iterCount-1) %iterCount-1 has been taken because the last iteration did not change the centroid values
            C=centroids;
            V=centroid_label;
            break
        end
    end
    
    %combine clusters with Data
    new_data=[Data centroid_label'];
    x=new_data(:,1);
    y=new_data(:,2);
    g={new_data(:,3)};
    gscatter(x,y,g,'kgbmc','x',8,'on')
    hold on
    %plot centroids
    plt=plot(C(:,1),C(:,2),'kd')
    set(plt,'MarkerFaceColor','r')
    title('K-means clustering')
    legend off
    grid on
    hold off 
    
end   
        