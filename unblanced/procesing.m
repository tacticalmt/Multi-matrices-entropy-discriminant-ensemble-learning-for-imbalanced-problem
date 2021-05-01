load Imbalanced_data.mat;
[col,row]=size(Imbalanced_data);
for i_col=1:col
   data_temp=Imbalanced_data{i_col,3}; 
   index_neg_tr=find(data_temp{1,1}(:,end)==0);
   index_pos_tr=find(data_temp{1,1}(:,end)==1);%找出类标号为0和为1的样本标号on训练集
   data_tr_neg=data_temp{1,1}(index_neg_tr(1:end),:);
   data_tr_pos=data_temp{1,1}(index_pos_tr(1:end),:);
   %----------------------------------------
   index_neg_te=find(data_temp{1,2}(:,end)==0);
   index_pos_te=find(data_temp{1,2}(:,end)==1);%找出类标号为0和为1的样本标号on测试部分
   data_te_neg=data_temp{1,2}(index_neg_te(1:end),:);
   data_te_pos=data_temp{1,2}(index_pos_te(1:end),:);
   data_neg=[data_tr_neg;data_te_neg];
   data_pos=[data_tr_pos;data_te_pos];%正负类样本合成
   data=[data_pos;data_neg];
   label=data(:,end);
   data(:,end)=[];
   data=data';
   label(find(label==0))=2;
   [~,loc_t]=unique(label);
   n1=loc_t(1);
   n2=loc_t(2)-n1;%两个类的数量
   for i_iter=1:10
   oneclass_rand=randperm(n1);
   twoclass_rand=randperm(n2);
   index_struct(i_iter,1).index=oneclass_rand;
   index_struct(i_iter,2).index=twoclass_rand;
   end
   dataname=strcat(Imbalanced_data{i_col,1},'.mat');
   save(dataname,'data','label','index_struct');
end