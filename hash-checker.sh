#!/bin/bash
# Script Bash sederhana untuk mengecek nilai Hash pada sebuah File
function input_hash_md5(){
	while true; do
		read -p "[#] Masukkan Hash MD5: " hash_md5
		if [[ -z "${hash_md5}" ]]; then
			echo "[-] Hash MD5 tidak boleh kosong."
			continue
		else
			if [[ "${hash_md5}" =~ ^[a-fA-F0-9]{32}$ ]]; then
				break
			else
				echo "[-] Hash MD5 tidak valid."
				continue
			fi
		fi
	done
}

function input_hash_sha1(){
	while true; do
		read -p "[#] Masukkan Hash SHA-1: " hash_sha1
		if [[ -z "${hash_sha1}" ]]; then
			echo "[-] Hash SHA-1 tidak boleh kosong."
			continue
		else
			if [[ "${hash_sha1}" =~ ^[a-fA-F0-9]{40}$ ]]; then
				break
			else
				echo "[-] Hash SHA-1 tidak valid."
				continue
			fi
		fi
	done
}

function input_hash_sha256(){
	while true; do
		read -p "[#] Masukkan Hash SHA-256: " hash_sha256
		if [[ -z "${hash_sha256}" ]]; then
			echo "[-] Hash SHA-256 tidak boleh kosong."
			continue
		else
			if [[ "${hash_sha256}" =~ ^[a-fA-F0-9]{64}$ ]]; then
				break
			else
				echo "[-] Hash SHA-256 tidak valid."
				continue
			fi
		fi
	done
}

function input_hash_sha512(){
	while true; do
		read -p "[#] Masukkan Hash SHA-512: " hash_sha512
		if [[ -z "${hash_sha512}" ]]; then
			echo "[-] Hash SHA-512 tidak boleh kosong."
			continue
		else
			if [[ "${hash_sha512}" =~ ^[a-fA-F0-9]{128}$ ]]; then
				break
			else
				echo "[-] Hash SHA-512 tidak valid."
				continue
			fi
		fi
	done
}

function input_file(){
	while true; do
		read -p "[#] Masukkan nama file yang mau dicek nilai Hashnya: " file
		if [[ -z "${file}" ]]; then
			echo "[-] Nama file tidak boleh kosong."
			continue
		else
			if [[ -f "${file}" ]]; then
				break
			else
				echo "[-] File '${file}' tidak ditemukan."
				continue
			fi
		fi
	done
}

function cek_hash_md5(){
	input_hash_md5
	input_file

	hash_file=$(md5sum "${file}" | awk '{print $1}')

	if [[ "${hash_md5}" == "${hash_file}" ]]; then
		echo "[+] Hash MD5 sama."
		exit 0
	else
		echo "[-] Hash MD5 tidak sama."
		exit 1
	fi
}

function cek_hash_sha1(){
	input_hash_sha1
	input_file

	hash_file=$(sha1sum "${file}" | awk '{print $1}')

	if [[ "${hash_sha1}" == "${hash_file}" ]]; then
		echo "[+] Hash SHA-1 sama."
		exit 0
	else
		echo "[-] Hash Sha-1 tidak sama."
		exit 1
	fi
}

function cek_hash_sha256(){
	input_hash_sha256
	input_file

	hash_file=$(sha256sum "${file}" | awk '{print $1}')

	if [[ "${hash_sha256}" == "${hash_file}" ]]; then
		echo "[+] Hash SHA-256 sama."
		exit 0
	else
		echo "[-] Hash Sha-256 tidak sama."
		exit 1
	fi
}

function cek_hash_sha512(){
	input_hash_sha512
	input_file

	hash_file=$(sha512sum "${file}" | awk '{print $1}')

	if [[ "${hash_sha512}" == "${hash_file}" ]]; then
		echo "[+] Hash SHA-512 sama."
		exit 0
	else
		echo "[-] Hash Sha-512 tidak sama."
		exit 1
	fi
}

function cek_semua_hash(){
	input_hash_md5
	input_hash_sha1
	input_hash_sha256
	input_hash_sha512
	input_file

   	# Menghitung semua hash file
	hash_file_md5=$(md5sum "${file}" | awk '{print $1}')
  	hash_file_sha1=$(sha1sum "${file}" | awk '{print $1}')
	hash_file_sha256=$(sha256sum "${file}" | awk '{print $1}')
	hash_file_sha512=$(sha512sum "${file}" | awk '{print $1}')

	hash_sama=()
	hash_tidak_sama=()

	echo "[*] Mengecek semua Hash..."

	if [[ "${hash_md5}" == "${hash_file_md5}" ]]; then
	 	echo "[+] Hash MD5 sama."
		hash_sama+=("MD5")
	else
	        echo "[-] Hash MD5 tidak sama."
		hash_tidak_sama+=("MD5")
	fi

	if [[ "${hash_sha1}" == "${hash_file_sha1}" ]]; then
	        echo "[+] Hash SHA-1 sama."
		hash_sama+=("SHA-1")
	else
	        echo "[-] Hash SHA-1 tidak sama."
		hash_tidak_sama+=("SHA-1")
	fi

	if [[ "${hash_sha256}" == "${hash_file_sha256}" ]]; then
	        echo "[+] Hash SHA-256 sama."
		hash_sama+=("SHA-256")
	else
	        echo "[-] Hash SHA-256 tidak sama."
		hash_tidak_sama+=("SHA-256")
	fi

	if [[ "${hash_sha512}" == "${hash_file_sha512}" ]]; then
	        echo "[+] Hash SHA-512 sama."
		hash_sama+=("SHA-512")
	else
	        echo "[-] Hash SHA-512 tidak sama."
		hash_tidak_sama+=("SHA-512")
	fi

	if [[ "${#hash_sama[@]}" -eq 4 ]]; then
		echo "[+] Semua Hash sama."
	else
		echo "[-] Ada Hash yang tidak sama."
		echo ""
		for hts in "${hash_tidak_sama[@]}"; do
			echo "- ${hts}"
		done
	fi
}

function main(){
	cowsay "Welcome to Hash Checker"
	echo ""
	echo "Script Bash sederhana untuk mengecek nilai Hash"
	echo "pada sebuah File"
	echo ""
	echo "Daftar Menu:"
	echo ""
	echo "[1] Cek Hash MD5"
	echo "[2] Cek Hash SHA-1"
	echo "[3] Cek Hash SHA-256"
	echo "[4] Cek Hash SHA-512"
	echo "[5] Cek Semua Hash (MD5, SHA-1, SHA-256, SHA-512)"
	echo ""

	while true; do
		read -p "[#] Pilih Menu: " pilih_menu

		if [[ "${pilih_menu}" == "1" ]]; then
			cek_hash_md5
		elif [[ "${pilih_menu}" == "2" ]]; then
			cek_hash_sha1
		elif [[ "${pilih_menu}" == "3" ]]; then
			cek_hash_sha256
		elif [[ "${pilih_menu}" == "4" ]]; then
			cek_hash_sha512
		elif [[ "${pilih_menu}" == "5" ]]; then
			cek_semua_hash
		fi
	done
}

main
