#include <QCoreApplication>
#include <QImage>
#include <bits/stdc++.h>

using namespace std;

#define FILENAME "rocks.jpg"

const int START_WINDOW_SIZE = 11;

const int FIND_OFFSET_STEP = 4;

const bool SHOW_BORDER = false;

pair<int,int> dpos[4] = {{1,0},{-1,0},{0,1},{0,-1}};

vector<vector<QRgb> > QImageToVector(const QImage& img){
    int w = img.width();
    int h = img.height();

    vector<vector<QRgb> > res = vector<vector<QRgb> >(h,vector<QRgb>(w,0));

    for(int i=0;i<h;i++){
        for(int j=0;j<w;j++){
            res[i][j] = img.pixel(j,i);
        }
    }

    return res;
}

QImage VectorToQImage(const vector<vector<QRgb> >& vec){
    int w = vec[0].size();
    int h = vec.size();

    QImage res = QImage(w,h,QImage::Format_RGB32);

    for(int i=0;i<h;i++){
        for(int j=0;j<w;j++){
            res.setPixel(j,i,vec[i][j]);
        }
    }

    return res;
}

vector<vector<QRgb> > rotate(const vector<vector<QRgb> >& vec){
    int w = vec[0].size();
    int h = vec.size();

    vector<vector<QRgb> > res = vector<vector<QRgb> >(w,vector<QRgb>(h,0));

    for(int i=0;i<h;i++){
        for(int j=0;j<w;j++){
            res[w-j-1][i]=vec[i][j];
        }
    }

    return res;
}

vector<vector<QRgb> > unrotate(const vector<vector<QRgb> >& vec){
    return rotate(rotate(rotate(vec)));
}


int colorDifference(const QRgb& c1,const QRgb& c2){
    int c1r = qRed(c1);
    int c1g = qGreen(c1);
    int c1b = qBlue(c1);
    int c2r = qRed(c2);
    int c2g = qGreen(c2);
    int c2b = qBlue(c2);
    return (c1r-c2r)*(c1r-c2r)+(c1g-c2g)*(c1g-c2g)+(c1b-c2b)*(c1b-c2b);
}


int findOffset(const vector<vector<QRgb> >& vec){
    int w = vec[0].size();
    int h = vec.size();

    double best = 1e18;
    int res = -1;

    for(int k=max(START_WINDOW_SIZE,20);k<w/2;k+=FIND_OFFSET_STEP){
        long long sum = 0;
        for(int i=0;i<h;i++){
            for(int j=0;j<k;j++){
                sum += colorDifference(vec[i][w-k+j],vec[i][j]);
            }
        }
        double average = 1.0*sum/h/k;
        cout << k << "->" << average << endl;
        if(average<best){
            best = average;
            res = k;
        }
    }
    return res;
}

vector<vector<double> > defineCosts(const vector<vector<QRgb> >& vec,const int& k){
    int w = vec[0].size();
    int h = vec.size();

    vector<vector<double> > res = vector<vector<double> >(h,vector<double>(k,0));

    for(int i=0;i<h;i++){
        for(int j=0;j<k;j++){
            res[i][j] = colorDifference(vec[i][w-k+j],vec[i][j]);
        }
    }

    return res;
}


typedef pair<double, pair<int,int> > doublePair;

vector<pair<int, int> > dijkstraWithPQ(const vector<vector<double> >& costs,const int& j0){
    int i0 = 0;

    int k = costs[0].size();
    int h = costs.size();
    vector<vector<double> > dist = vector<vector<double> >(h,vector<double>(k,1e18));
    vector<vector<pair<int,int> > > prev = vector<vector<pair<int,int> > >(h,vector<pair<int,int> >(k,make_pair(-1,-1)));

    dist[i0][j0]=0;

    priority_queue<doublePair, vector<doublePair>, greater<doublePair> > Q;

    Q.push(make_pair(0.0, make_pair(i0,j0)));

    int nbProcessed = 1;

    while(!Q.empty()){
        pair<int,int> u = Q.top().second;
        Q.pop();

        int i1 = u.first;
        int j1 = u.second;

        nbProcessed++;

        for(int a=0;a<4;a++){
            int vi = dpos[a].first + i1;
            int vj = dpos[a].second + j1;
            if(vi>=0&&vi<h&&vj>=0&&vj<k){
                double alt = dist[i1][j1] + (costs[i1][j1]+costs[vi][vj]);
                if(alt<dist[vi][vj]){
                    dist[vi][vj] = alt;
                    prev[vi][vj] = u;
                    Q.push(make_pair(dist[vi][vj], make_pair(vi,vj)));
                }
            }
        }
    }

    double the_min = 1e18;
    double jend = -1;
    for(int j=0;j<k;j++){
        if(dist[h-1][j]<the_min){
            the_min = dist[h-1][j];
            jend = j;
        }
    }

    cout << "THE MIN DISTANCE WITH DIJKSTRA_PQ : " << the_min << endl;

    vector<pair<int,int> > res;
    pair<int,int> end = make_pair(h-1,jend);
    res.push_back(end);

    pair<int,int> cur = end;

    while(cur.first!=i0||cur.second!=j0){
        cur = prev[cur.first][cur.second];
        res.push_back(cur);
    }

    cout << "Finished Dijstra\n";

    return res;
}

int findStart(const vector<vector<double> >& costs){
    int half=(START_WINDOW_SIZE-1)/2;
    int k = costs[0].size();
    int h = costs.size();

    double the_min = 1e18;
    int ind = -1;
    for(int ii=half;ii<k-half;ii++){
        long long sum = 0;
        for(int i=0;i<=half;i++){
            for(int j=ii-half;j<=ii+half;j++){
                sum += costs[i][j];
            }
        }
        if(sum<the_min){
            the_min = sum;
            ind = ii;
        }
    }

    return ind;
}


void floodFill(vector<vector<QRgb> >& res1, const int& i0, const int& j0,const int& value){
    int w = res1[0].size();
    int h = res1.size();

    res1[i0][j0] = value;

    stack<pair<int,int> > s;
    s.push(make_pair(i0,j0));

    while(!s.empty()){
        pair<int,int> p = s.top();
        s.pop();
        for(int a=0;a<4;a++){
            int vi = dpos[a].first + p.first;
            int vj = dpos[a].second + p.second;
            if(vi>=0&&vi<h&&vj>=0&&vj<w&&res1[vi][vj]==0){
                res1[vi][vj] = value;
                s.push(make_pair(vi,vj));
            }
        }
    }
}

vector<vector<QRgb> > imageFromDijsktra(const vector<vector<QRgb> >& im, const int& offset, const vector<pair<int,int> >& fr){
    int w = im[0].size();
    int h = im.size();
    vector<vector<QRgb> > res1 = vector<vector<QRgb> >(h,vector<QRgb>(2*w-offset,0));
    vector<vector<QRgb> > res2 = res1;

    for(pair<int,int> p : fr){
        int i = p.first;
        int j = p.second;
        res1[i][w-offset+j] = 3;
    }

    floodFill(res1,h/2,0,1);
    floodFill(res1,h/2,2*w-offset-1,2);

    for(int i=0;i<h;i++){
        for(int j=0;j<2*w-offset;j++){
            if(j<w-offset||(j<w&&res1[i][j]==1)){
                res2[i][j] = im[i][j];
            } else if(j>=w||(j>=w-offset&&res1[i][j]==2)){
                res2[i][j] = im[i][j-w+offset];
            } else {
                QRgb c1 = im[i][j];
                QRgb c2 = im[i][j-w+offset];
                if(SHOW_BORDER){
                    res2[i][j] = qRgba(255,0,0,255);
                } else {
                    res2[i][j] = qRgba((qRed(c1)+qRed(c2))/2,(qGreen(c1)+qGreen(c2))/2,(qBlue(c1)+qBlue(c2))/2,255);
                }
            }
        }
    }

    return res2;
}

QImage performAlgoH(const QImage& img){
    vector<vector<QRgb> > vec = QImageToVector(img);

    QImage testimg = VectorToQImage(vec);

    testimg.save("testsave2.png");

    int offset = findOffset(vec);

    cout << "Found offset : " << offset << endl;

    vector<vector<double> > costs = defineCosts(vec,offset);

    int j0 = findStart(costs);

    cout << "j0 : " << j0 << endl;

    vector<pair<int,int> > fr = dijkstraWithPQ(costs,j0);

    cout << "Dijkstra Finised\n";

    vector<vector<QRgb> > vec2 = imageFromDijsktra(vec,offset,fr);

    cout << "Flood Fill done\n";

    QImage resimg = VectorToQImage(vec2);

    return resimg;
}

QImage performAlgoV(const QImage& img){
    vector<vector<QRgb> > vec0 = QImageToVector(img);

    vector<vector<QRgb> > vec = rotate(vec0);

    QImage testimg = VectorToQImage(vec);

    testimg.save("testsave2.png");

    int offset = findOffset(vec);

    cout << "Found offset : " << offset << endl;

    vector<vector<double> > costs = defineCosts(vec,offset);

    int j0 = findStart(costs);

    cout << "j0 : " << j0 << endl;

    vector<pair<int,int> > fr = dijkstraWithPQ(costs,j0);

    cout << "Dijkstra Finised\n";

    vector<vector<QRgb> > vec2 = imageFromDijsktra(vec,offset,fr);

    cout << "Flood Fill done\n";

    vector<vector<QRgb> > vec3 = unrotate(vec2);

    QImage resimg = VectorToQImage(vec3);

    return resimg;
}

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    QImage img;

    img.load(FILENAME);

    QImage resimg = performAlgoH(img);

    resimg = performAlgoV(resimg);
/*
    resimg = performAlgoV(resimg);

    resimg = performAlgoH(resimg);*/

    resimg.save("result7normal.png");

    return a.exec();
}

