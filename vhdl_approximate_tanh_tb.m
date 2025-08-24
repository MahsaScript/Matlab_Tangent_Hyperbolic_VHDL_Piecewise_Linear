function vhdl_approximate_tanh_tb
  % Test inputs

  x_8  = fi(-5:0.08:5,1,8);
  x_16 = fi(-5:0.08:5,1,16);
  x_32 = fi(-5:0.08:5,1,32);
  % Run
 y = tanh( double(x_8));
 y_tanh_piecewise_8 = vhdl_approximate_tanh_design(double(x_8));   % 8 bits
 y_tanh_piecewise_16 = vhdl_approximate_tanh_design( double( x_16));   % 16 bits
 y_tanh_piecewise_32 = vhdl_approximate_tanh_design( double( x_32));   % 32 bits


    tanh_piecewise = vhdl_approximate_tanh_design(double( x_8));
    % tanh_piecewise = tanh(x1);
    a=find(x_8==-5);
    b=find(x_8==-3);
    c=find(x_8==-1);
    d=find(x_8==1);
    e=find(x_8==3);
    f=find(x_8==5);

    y1=y_tanh_piecewise_8([a]);
    y2=y_tanh_piecewise_8([b]);
    y3=y_tanh_piecewise_8([c]);
    y4=y_tanh_piecewise_8([d]);
    y5=y_tanh_piecewise_8([e]);
    y6=y_tanh_piecewise_8([f]);

    disp(size(y2));
    disp(size(y1));
    aa=(y2-y1);
    disp(size(aa));
    bb=(x_8(b)-x_8([a]));
    disp(size(bb));
    m1=(y2-y1)/(x_8(b)-x_8([a]));
    m2=(y3-y2)/(x_8(c)-x_8([b]));
    m3=(y4-y3)/(x_8(d)-x_8([c]));
    m4=(y5-y4)/(x_8(e)-x_8([d]));
    m5=(y6-y5)/(x_8(f)-x_8([e]));

    b1=y1-m1*x_8([a]);
    b2=y2-m2*x_8([b]);
    b3=y3-m3*x_8([c]);
    b4=y4-m4*x_8([d]);
    b5=y5-m5*x_8([e]);
Y1=(m1*x_8(1:21))+b1;
Y2=(m2*x_8(22:43))+b2;
Y3=(m3*x_8(44:65))+b3;
Y4=(m4*x_8(66:87))+b4;
Y5=(m5*x_8(88:110))+b5;

    Y = [Y1 Y2 Y3 Y4 Y5];
    figure;
    plot(x_8(1:21),Y1)
    hold on
    plot(x_8(22:43),Y2)
    hold on
    plot(x_8(44:65),Y3)
    hold on
    plot(x_8(66:87),Y4)
    hold on 
    plot(x_8(88:110),Y5)
    hold on
    plot(x_8, y)

    title("tanh(x)& piecewise linear 8 bits aproximation." );
    xlabel('x');
    ylabel('tanh(x)');
  
  
  error8_ = RMSE(y_tanh_piecewise_8,y);
  formatSpec = '%.10f';
  error8_=num2str(error8_,formatSpec);
  disp("error 8 bits:" + error8_);
 
  figure;
  err = abs(y - double(y_tanh_piecewise_8));
  plot(x_8, err);
  xlabel('theta');
  ylabel('error');
  title("tanh(x)& piecewise linear 8 bits aproximation Error = " + error8_);
  grid on;
  
  
%     error = RMSE(t1,Y);
%     formatSpec = '%.10f';
%     error_=num2str(error,formatSpec);
%     disp(error_);
%     title("tanh(x)& piecewise linear Error = " + error_);
%     figure;
%     err = abs(tanh(x_8) - double(Y));
%     plot(x_8, err);
%     xlabel('theta');
%     ylabel('error');
%     title("tanh(x)& piecewise aproximation Error = " + error_);
%     formatSpec = '%.10f';
%     error_=num2str(error,formatSpec);
%     disp(num2str(error,formatSpec));
end


