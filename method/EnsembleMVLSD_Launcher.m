warning off;
k=[3];
C=[0.01,0.1,1,10,100];
lam=[0,0.2,0.4,0.5,0.8,1];
ensemble=10;
gamma=[0.01,0.1,1,10,100];
u_u = 0.5;
b_b = 10^(-6);
data_num=1;%����ѡ��
dataset='Imbalanced_data';
dataset_imported=load(['..\imbalanced_fcv\',dataset,'.mat']);
%------------����ͬ���ݼ���ʽ���õ��뷽��
% dataset='Imbalanced_data';
for i_data=12
Basic_para.datanName=dataset_imported.Imbalanced_data{i_data,1};
Basic_para.vail_type='FCV';
Basic_para.ktimes=5;%������֤������Ҳ�������óɸ����ݼ�����Ӧ
Basic_para.label=dataset_imported.Imbalanced_data{i_data,3}{1,1}(:,end);
Basic_para.IR=dataset_imported.Imbalanced_data{i_data,2};

Basic_para.label(find(Basic_para.label==0))=2;
% dataset_struct=load(['..\imbalanced_fcv\',dataset,'.mat']);
dataset_struct=dataset_imported.Imbalanced_data{i_data,3};
Basic_para.std_vec=dataset_imported.Imbalanced_data{i_data,3}{1,1}(1,1:(end-1));%��һ��������std�����ڼ�����󻯸���
%-------------
for i_k=1:length(k)
    for i_C=1:length(C)
        for i_lam=1:length(lam)
            for i_gamma=1:length(gamma)
                EnsembleMVLSD_main(dataset_struct,Basic_para,ensemble,k(i_k),C(i_C),lam(i_lam),gamma(i_gamma),u_u,b_b);
            end%end gamma
        end%end lamda
    end%end C
end%end k
end