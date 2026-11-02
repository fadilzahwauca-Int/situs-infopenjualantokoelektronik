import os
from flask import Flask, render_template, request, redirect, session, url_for
import mysql.connector
from werkzeug.security import generate_password_hash, check_password_hash  
 
app = Flask(__name__, template_folder='templates') 
app.secret_key = 'techmart_secret_key'

db_config = {
    'host': os.environ.get('DB_HOST', '127.0.0.1'),
    'user': os.environ.get('DB_USER', 'root'),
    'password': os.environ.get('DB_PASSWORD', ''),
    'database': os.environ.get('DB_NAME', 'db_techmart'),
    'port': int(os.environ.get('DB_PORT', 3306)) 
}

def get_db_connection():
    conn = mysql.connector.connect(**db_config)
    return conn

@app.route('/signup', methods=['GET', 'POST'])
def signup():
    if request.method == 'POST':
        nama_lengkap = request.form['nama_lengkap']
        username = request.form['username']
        email = request.form['email']
        password = request.form['password']
        confirm_password = request.form['confirm_password']
        
        if password != confirm_password:
            return "<script>alert('Konfirmasi password tidak cocok!'); window.history.back();</script>"

        hashed_password = generate_password_hash(password)
        
        conn = get_db_connection()
        cursor = conn.cursor()
        try:
            query = "INSERT INTO users (nama_lengkap, username, email, password) VALUES (%s, %s, %s, %s)"
            cursor.execute(query, (nama_lengkap, username, email, hashed_password))
            conn.commit()
            cursor.close()
            conn.close()
            return "<script>alert('Registrasi berhasil! Silakan login.'); window.location.href='/login';</script>"
        except mysql.connector.Error as err:
            cursor.close()
            conn.close()
            return "<script>alert('Gagal mendaftar: Username atau Email sudah digunakan!'); window.history.back();</script>"
            
    return render_template('signup.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username_or_email = request.form['username']
        password = request.form['password']
        
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        query = "SELECT * FROM users WHERE username = %s OR email = %s"
        cursor.execute(query, (username_or_email, username_or_email))
        user = cursor.fetchone()
        cursor.close()
        conn.close()
        
        if user and check_password_hash(user['password'], password):
            session['user_id'] = user['id_user']
            session['username'] = user['username']
            session['nama_lengkap'] = user['nama_lengkap']
            return redirect(url_for('index'))
        else:
            return "<script>alert('Username/Email atau Password salah!'); window.history.back();</script>"
            
    return render_template('login.html')

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('login')) 

@app.route('/forgot-password', methods=['GET', 'POST'])
def forgot_password():
    if request.method == 'POST':
        username_or_email = request.form['username_or_email']
        new_password = request.form['new_password']
        confirm_new_password = request.form['confirm_new_password']
        
        if new_password != confirm_new_password:
            return "<script>alert('Konfirmasi password baru tidak cocok!'); window.history.back();</script>"
        
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        
        query = "SELECT * FROM users WHERE username = %s OR email = %s"
        cursor.execute(query, (username_or_email, username_or_email))
        user = cursor.fetchone()
        
        if user:
            hashed_password = generate_password_hash(new_password)
            
            update_query = "UPDATE users SET password = %s WHERE id_user = %s"
            cursor.execute(update_query, (hashed_password, user['id_user']))
            conn.commit()
            cursor.close()
            conn.close()
            return "<script>alert('Password berhasil diubah! Silakan login dengan password baru.'); window.location.href='/login';</script>"
        else:
            cursor.close()
            conn.close()
            return "<script>alert('Username atau Email tidak ditemukan di sistem!'); window.history.back();</script>"
            
    return render_template('forgot_password.html')

@app.route('/terms')
def terms():
    return render_template('terms.html')

@app.route('/')
def index():
    if 'user_id' not in session:
        return redirect(url_for('login')) 
    return render_template('index.html', username=session['username'], nama_lengkap=session['nama_lengkap'])

@app.route('/produk')
def produk():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM produk")
    data_produk = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('produk.html', produk=data_produk)

@app.route('/produk/tambah', methods=['GET', 'POST'])
def tambah_produk():
    if request.method == 'POST':
        nama = request.form['nama_produk']
        kategori = request.form['kategori']
        harga = request.form['harga']
        stok = request.form['stok']
        
        conn = get_db_connection()
        cursor = conn.cursor()
        query = "INSERT INTO produk (nama_produk, kategori, harga, stok) VALUES (%s, %s, %s, %s)"
        cursor.execute(query, (nama, kategori, harga, stok))
        conn.commit()
        cursor.close()
        conn.close()
        return redirect(url_for('produk'))
    return render_template('tambah_produk.html')

@app.route('/produk/edit/<int:id>', methods=['GET', 'POST'])
def edit_produk(id):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    
    if request.method == 'POST':
        nama = request.form['nama_produk']
        kategori = request.form['kategori']
        harga = request.form['harga']
        stok = request.form['stok']
        
        query = "UPDATE produk SET nama_produk=%s, kategori=%s, harga=%s, stok=%s WHERE id_produk=%s"
        cursor.execute(query, (nama, kategori, harga, stok, id))
        conn.commit()
        cursor.close()
        conn.close()
        return redirect(url_for('produk'))
        
    cursor.execute("SELECT * FROM produk WHERE id_produk = %s", (id,))
    p = cursor.fetchone()
    if produk['stok'] < jml:
    cursor.close()
    conn.close()
    return render_template('edit_produk.html', produk=p)

@app.route('/produk/hapus/<int:id>')
def hapus_produk(id):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM produk WHERE id_produk = %s", (id,))
    conn.commit()
    cursor.close()
    conn.close()
    return redirect(url_for('produk')) 

@app.route('/pelanggan')
def pelanggan():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM pelanggan")
    data_pelanggan = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('pelanggan.html', pelanggan=data_pelanggan)

@app.route('/pelanggan/tambah', methods=['GET', 'POST'])
def tambah_pelanggan():
    if request.method == 'POST':
        nama = request.form['nama_pelanggan']
        alamat = request.form['alamat']
        telepon = request.form['telepon']
        
        conn = get_db_connection()
        cursor = conn.cursor()
        query = "INSERT INTO pelanggan (nama_pelanggan, alamat, telepon) VALUES (%s, %s, %s)"
        cursor.execute(query, (nama, alamat, telepon))
        conn.commit()
        cursor.close()
        conn.close()
        return redirect(url_for('pelanggan'))
    return render_template('tambah_pelanggan.html')

@app.route('/pelanggan/edit/<int:id>', methods=['GET', 'POST'])
def edit_pelanggan(id):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    
    if request.method == 'POST':
        nama = request.form['nama_pelanggan']
        alamat = request.form['alamat']
        telepon = request.form['telepon']
        
        query = "UPDATE pelanggan SET nama_pelanggan=%s, alamat=%s, telepon=%s WHERE id_pelanggan=%s"
        cursor.execute(query, (nama, alamat, telepon, id))
        conn.commit()
        cursor.close()
        conn.close()
        return redirect(url_for('pelanggan'))
        
    cursor.execute("SELECT * FROM pelanggan WHERE id_pelanggan = %s", (id,))
    pl = cursor.fetchone()
    cursor.close()
    conn.close()
    return render_template('edit_pelanggan.html', pelanggan=pl)

@app.route('/pelanggan/hapus/<int:id>')
def hapus_pelanggan(id):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM pelanggan WHERE id_pelanggan = %s", (id,))
    result = cursor.fetchone()
    
    if transaksi_terkait:
        cursor.close()
        conn.close()
        return """
            <script>
                alert('Pelanggan ini tidak dapat dihapus karena memiliki riwayat transaksi!');
                window.location.href = '/pelanggan';
            </script>
        """

    cursor.execute("DELETE FROM pelanggan WHERE id_pelanggan = %s", (id,))
    conn.commit()
    cursor.close()
    conn.close()
    return redirect(url_for('pelanggan')) 

@app.route('/transaksi')
def transaksi():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    query = """
        SELECT t.id_transaksi, t.tanggal_transaksi, t.total_bayar, p.nama_pelanggan 
        FROM transaksi t 
        JOIN pelanggan p ON t.id_pelanggan = p.id_pelanggan
    """
    cursor.execute(query)
    data_transaksi = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('transaksi.html', transaksi=data_transaksi) 

@app.route('/transaksi/tambah', methods=['GET', 'POST'])
def tambah_transaksi():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    
    if request.method == 'POST':
        id_pelanggan = request.form['id_pelanggan']
        id_produk = request.form['id_produk']
        jml = int(request.form['jml'])
        tanggal = request.form['tanggal_transaksi']
        
        cursor.execute("SELECT harga FROM produk WHERE id_produk = %s", (id_produk,))
        produk = cursor.fetchone()

        if produk['stok'] < jml:
            return """
                <script>
                    alert('Stok tidak mencukupi! Stok tersedia: {}');
                    window.history.back();
                </script>
            """.format(produk['stok'])

        harga = produk['harga']
        subtotal = harga * jml
        
        query_trans = "INSERT INTO transaksi (tanggal_transaksi, total_bayar, id_pelanggan) VALUES (%s, %s, %s)"
        cursor.execute(query_trans, (tanggal, subtotal, id_pelanggan))
        conn.commit()
        
        id_transaksi_baru = cursor.lastrowid
        
        query_detail = "INSERT INTO detail_transaksi (jml, subtotal, id_transaksi, id_produk) VALUES (%s, %s, %s, %s)"
        cursor.execute(query_detail, (jml, subtotal, id_transaksi_baru, id_produk))
        conn.commit()
        
        cursor.execute("UPDATE produk SET stok = stok - %s WHERE id_produk = %s", (jml, id_produk))
        conn.commit()
        
        cursor.close()
        conn.close()
        return redirect(url_for('transaksi'))

    cursor.execute("SELECT id_pelanggan, nama_pelanggan FROM pelanggan")
    list_pelanggan = cursor.fetchall()
    
    cursor.execute("SELECT id_produk, nama_produk, harga, stok FROM produk WHERE stok > 0")
    list_produk = cursor.fetchall()
    
    cursor.close()
    conn.close()
    return render_template('tambah_transaksi.html', pelanggan=list_pelanggan, produk=list_produk)

@app.route('/detail-transaksi')
def detail_transaksi():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    query = """
        SELECT dt.id_detail, dt.jml, dt.subtotal, dt.id_transaksi, p.nama_produk 
        FROM detail_transaksi dt 
        JOIN produk p ON dt.id_produk = p.id_produk
    """
    cursor.execute(query)
    data_detail = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('detail_transaksi.html', detail=data_detail)

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 8080))
    app.run(host='0.0.0.0', port=port, debug=False) 
