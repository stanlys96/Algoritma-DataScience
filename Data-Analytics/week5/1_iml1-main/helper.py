import matplotlib.pyplot as plt
import plotly.express as px # for data visualization
import plotly.graph_objects as go # for data visualization
import warnings
import numpy as np
warnings.filterwarnings('ignore')

# a simple plotting utility (don't change and don't care about this func, just use it)
def create_plot_svr_2_model(df, model1, model2):
    X = df['carat']
    y = df['price']
    x_range = np.linspace(X.min(), X.max(), 100)

    y_m1 = model1.predict(x_range.reshape(-1, 1)) # Model 1
    y_m2 = model2.predict(x_range.reshape(-1, 1)) # Model 2

    fig = px.scatter(df, x=X, y=y, opacity=0.8, color_discrete_sequence=['black'])

    # add a best-fit line
    name_model1 = type(model1).__name__
    if name_model1 == 'SVR':
        epsilon1 = model1.get_params()['epsilon']
        C1 = model1.get_params()['C']
        name_model1 = "{} (epsilon={}, C={})".format(name_model1, epsilon1, C1)
        
    name_model2 = type(model2).__name__
    if name_model2 == 'SVR':
        epsilon2 = model2.get_params()['epsilon']
        C2 = model2.get_params()['C']
        name_model2 = "{} (epsilon={}, C={})".format(name_model2, epsilon2, C2)
        fig.add_traces(go.Scatter(x=x_range, y=y_m2+epsilon2, name='+epsilon', line=dict(color='red', dash='dot')))
        fig.add_traces(go.Scatter(x=x_range, y=y_m2-epsilon2, name='-epsilon', line=dict(color='red', dash='dot')))
        
    fig.add_traces(go.Scatter(x=x_range, y=y_m1, name=name_model1, line=dict(color='limegreen')))
    fig.add_traces(go.Scatter(x=x_range, y=y_m2, name=name_model2, line=dict(color='red'))) 

    # change chart background color
    fig.update_layout(dict(plot_bgcolor = 'white'))

    # update axes lines
    fig.update_xaxes(showgrid=True, gridwidth=1, gridcolor='lightgrey', 
                  zeroline=True, zerolinewidth=1, zerolinecolor='lightgrey', 
                  showline=True, linewidth=1, linecolor='black')

    fig.update_yaxes(showgrid=True, gridwidth=1, gridcolor='lightgrey', 
                  zeroline=True, zerolinewidth=1, zerolinecolor='lightgrey', 
                  showline=True, linewidth=1, linecolor='black')

    # set figure title
    fig.update_layout(title="Diamonds Price Predictions Based on Carat Values", font=dict(color='black'))
    # update marker size
    fig.update_traces(marker=dict(size=3))

    fig.show()
    
# a simple plotting utility (don't change and don't care about this func, just use it)
def create_plot_svr(df, model):
    X = df['carat']
    y = df['price']
    x_range = np.linspace(X.min(), X.max(), 100)

    y_m = model.predict(x_range.reshape(-1, 1)) # Model 1
    fig = px.scatter(df, x=X, y=y, opacity=0.8, color_discrete_sequence=['black'])

    # add a best-fit line
    name_model = type(model).__name__
    if name_model == 'SVR':
        epsilon = model.get_params()['epsilon']
        C = model.get_params()['C']
        name_model = "{} (epsilon={}, C={})".format(name_model, epsilon, C)
        fig.add_traces(go.Scatter(x=x_range, y=y_m+epsilon, name='+epsilon', line=dict(color='red', dash='dot')))
        fig.add_traces(go.Scatter(x=x_range, y=y_m-epsilon, name='-epsilon', line=dict(color='red', dash='dot')))
        
    fig.add_traces(go.Scatter(x=x_range, y=y_m, name=name_model, line=dict(color='limegreen')))

    # change chart background color
    fig.update_layout(dict(plot_bgcolor = 'white'))

    # update axes lines
    fig.update_xaxes(showgrid=True, gridwidth=1, gridcolor='lightgrey', 
                  zeroline=True, zerolinewidth=1, zerolinecolor='lightgrey', 
                  showline=True, linewidth=1, linecolor='black')

    fig.update_yaxes(showgrid=True, gridwidth=1, gridcolor='lightgrey', 
                  zeroline=True, zerolinewidth=1, zerolinecolor='lightgrey', 
                  showline=True, linewidth=1, linecolor='black')

    # set figure title
    fig.update_layout(title="Diamonds Price Predictions Based on Carat Values", font=dict(color='black'))
    # update marker size
    fig.update_traces(marker=dict(size=3))

    fig.show()
    
# just function to plot SVC, don't change and don't care too much about it
def create_plot_svc(model, ax=None, plot_support=True):
    """Plot the decision function for a 2D SVC"""
    if ax is None:
        ax = plt.gca() # get current axis
    xlim = ax.get_xlim() # return the x-axis view limits
    ylim = ax.get_ylim() # return the y-axis view limits
    
    # create grid to evaluate model
    # `np.linspace` - returns number spaces (interval) evenly
    x = np.linspace(xlim[0], xlim[1], 30) 
    y = np.linspace(ylim[0], ylim[1], 30)
    
    # `np.meshgrid` to create a rect grid out of two given one-dimensional arrays representing the matrix indexing
    Y, X = np.meshgrid(y, x) 
    xy = np.vstack([X.ravel(), Y.ravel()]).T # `np.ravel` return one-line matrix, `np.vstack` stack the input into one array
    P = model.decision_function(xy).reshape(X.shape)
    
    # plot decision boundary and margins
    ax.contour(X, Y, P, colors='k',
               levels=[-1, 0, 1], alpha=0.5,
               linestyles=['--', '-', '--'])
    
    # plot support vectors
    if plot_support:
        ax.scatter(model.support_vectors_[:, 0],
                   model.support_vectors_[:, 1],
                   s=300, linewidth=1, facecolors='none');
    ax.set_xlim(xlim)
    ax.set_ylim(ylim)