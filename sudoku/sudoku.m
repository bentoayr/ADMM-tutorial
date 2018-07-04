n = 9;
known_data = [1,4,6;1,7,4;2,1,7;2,6,3;2,7,6;3,5,9;3,6,1;3,8,8;5,2,5;5,4,1;5,5,8;5,9,3;6,4,3;6,6,6;6,8,4;6,9,5;7,2,4;7,4,2;7,8,6;8,1,9;8,3,3;9,2,2;9,7,1;];
box_indices = 1:n;box_indices = reshape(box_indices,sqrt(n),sqrt(n));box_indices = kron(box_indices,ones(sqrt(n)));% box indexing
u_onlyOne_rows = randn(n,n,n);u_onlyOne_cols = randn(n,n,n);u_onlyOne_boxes = randn(n,n,n);u_onlyOne_cells = randn(n,n,n); % Initialization  (number , row, col)
m_onlyOne_rows = randn(n,n,n);m_onlyOne_cols = randn(n,n,n);m_onlyOne_boxes = randn(n,n,n);m_onlyOne_cells = randn(n,n,n);
u_knowThat = randn(n,n,n);m_knowThat = randn(n,n,n);z = randn(n,n,n);
for t = 1:1000
    % Process left nodes
    % First process knowThat nodes
    for i = 1:size(known_data,1) 
        number = known_data(i,3);pos_row = known_data(i,1);pos_col = known_data(i,2);
        [m_knowThat(:,pos_row,pos_col),u_knowThat(:,pos_row,pos_col)] = F_knowThat(number,z(:,pos_row,pos_col),u_knowThat(:,pos_row,pos_col));
    end
    % Second process onlyOne nodes
    for number = 1:n % rows
        for pos_row = 1:n
            [m_onlyOne_rows(number,pos_row,:), u_onlyOne_rows(number,pos_row,:)] = F_onlyOne(z(number,pos_row,:),u_onlyOne_rows(number,pos_row,:));
        end
    end
    for number = 1:n %columns
        for pos_col = 1:n
            [m_onlyOne_cols(number,:,pos_col),u_onlyOne_cols(number,:,pos_col)] = F_onlyOne(z(number,:,pos_col),u_onlyOne_cols(number,:,pos_col));
        end
    end
    for number = 1:n %boxes
        for pos_box = 1:n
            [pos_row,pos_col] = find(box_indices==pos_box); linear_indices_for_box_ele = sub2ind([n,n,n],number*ones(n,1),pos_row,pos_col);
            [m_onlyOne_boxes(linear_indices_for_box_ele),u_onlyOne_boxes(linear_indices_for_box_ele)] = 	F_onlyOne(z(linear_indices_for_box_ele),u_onlyOne_boxes(linear_indices_for_box_ele) );
        end
    end
    for pos_col = 1:n  %cells
        for pos_row = 1:n
            [m_onlyOne_cells(:,pos_col,pos_row),u_onlyOne_cells(:,pos_col,pos_row) ] = F_onlyOne(z(:,pos_col,pos_row),u_onlyOne_cells(:,pos_col,pos_row));
        end
    end
    % Process right nodes
    z = 0*z;z = (m_onlyOne_rows + m_onlyOne_cols + m_onlyOne_boxes + m_onlyOne_cells)/4;
    for i = 1:size(known_data,1)
        number = known_data(i,3);pos_row = known_data(i,1);pos_col = known_data(i,2);
        z(number,pos_row,pos_col) = (4*z(number,pos_row,pos_col) + m_knowThat(number,pos_row,pos_col))/5;
    end
    final = zeros(n);
    for i = 1:n
        final = final + i*reshape(z(i,:,:),n,n);
    end
    disp(final);
end
