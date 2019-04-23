clc
clear

% set up
dir_root = 'G:\sns_added';
dir_results = fullfile(dir_root, 'Data_rename');

cd(dir_root)

subjects = ls('sns*');

for sub = 3:size(subjects,1)
    disp(['Subject number: ' subjects(sub,:)])
    temp_folder = [subjects(sub,:)];
    temp_save = [dir_results filesep temp_folder];
    
    if ~exist(temp_save)
        mkdir(temp_save)
    end
    
    cd([dir_root filesep temp_folder])
    
    folder = ls('insta*');
    
    for FolderNum = 1:size(folder, 1)
        cd(folder(FolderNum,:));
        
        sub_folder = ls;
        sub_folder(1:2,:) = [];
        
        for SubFolderNum = 1:size(sub_folder, 1)
            try
                cd(sub_folder(SubFolderNum, :))
                
                image_list = rdir('**\*.jpg');
                try
                    for ImageNum = 1:size(image_list,1)
                        copyfile(image_list(ImageNum).name, temp_save);
                    end
                catch
                    
                end
                cd ..
            catch
            
            end
        end
        cd([dir_root filesep temp_folder]);
    end
    
    cd(temp_save);
    rename_list = rdir('**\*.jpg');
    
    for ImageNum = 1:size(rename_list,1)
        movefile(rename_list(ImageNum).name, [num2str(ImageNum, '%0.4d') '.jpg']);
    end
    
    cd(dir_root)
end
