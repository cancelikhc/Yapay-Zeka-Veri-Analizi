% Veritabanı Bağlantısı Kuruluyor
datasource = 'bist'; % Veritabanı adı
username = ''; % Kullanıcı adı
password = ''; % Şifre
% Veritabanına bağlantısı
conn = database(datasource, username, password);
% Bağlantı testi
if isopen(conn)
    disp('Veritabanına bağlanıldı.');
else
    error('Veritabanı bağlantısı başarısız: %s', conn.Message);
end
% sqlden veriyi çekiliyor
data = sqlread(conn, 'bist10');
% çekilen veri görüntüleniyor
disp(data);
% bağlantı kapatılıyor
close(conn);
disp('Veritabanı bağlantısı kapatıldı.');


% tablodaki veriler 0 ve 1'e dönüştürülüyor
data.endeks = double(strcmp(data.endeks, 'uygun'))*1 +...
    double(strcmp(data.endeks, 'degil'))*0;

data.kar_zarar = double(strcmp(data.kar_zarar, 'kar'))*1 +...
    double(strcmp(data.kar_zarar, 'zarar'))*0;

data.derinlik = double(strcmp(data.derinlik, 'alis'))*1 +...
    double(strcmp(data.derinlik, 'satis'))*0;

features = data(:, 2:end-1); % Son sütunu (sınıf) almıyoruz
labels = data(:, end); % Son sütun sınıf olarak belirlendi


% Naive Bayes modeli eğitiliyor
nbModel = fitcnb(features, labels);

disp('Naive Bayes modeli başarıyla eğitildi.');
disp(data)


% Tek bir test verisi oluşturma
testData = [0, 5000, 0, 0];
disp(testData)
%Modelin sınıf tahminini elde etme
predictedLabel = predict(nbModel, testData);

disp('Test Edilmek İstenen Veri:');
disp(testData);
disp('Veriye Göre Tahmin Edilen Sonuç:');
disp(predictedLabel);

