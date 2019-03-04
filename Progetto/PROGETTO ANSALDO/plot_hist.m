function [] = plot_hist(x, y, fig_id)

    bin=100;
    figure(fig_id)

    subplot(2,2,1)
    hist(x(:,1),bin)
    title('Potenza ventilatori')

    subplot(2,2,2)
    hist(x(:,2),bin)
    title('T amb')

    subplot(2,2,3)
    hist(x(:,3),bin)
    title('Portata da pressione')

    subplot(2,2,4)
    hist(y,bin)
    title('Pressione valle')

end