function error=RMSE(q_actual,q_desired)
    error=sqrt(sum((q_actual(:)-q_desired(:)).^2)/numel(q_actual));
end