from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service as ChromeService
from selenium.webdriver.chrome.options import Options as ChromeOptions
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as ExpectedConditions
from webdriver_manager.chrome import ChromeDriverManager
import pyotp
import requests
import os

chromeManager = ChromeDriverManager().install()
chromeOptions = ChromeOptions()
chromeOptions.add_argument('--ignore-certificate-errors')
chromeOptions.add_argument(f'--user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36')
chromeOptions.add_argument("--disable-extensions")
chromeOptions.add_experimental_option("detach", True)
chromeOptions.add_experimental_option("excludeSwitches", ['enable-automation'])

ACCOUNT = [["account","password","otp_secret","c:\xxx\run.exe"]]

def main():
    login(ACCOUNT[0][0],ACCOUNT[0][1],ACCOUNT[0][2],ACCOUNT[0][3])

def login(acct,pwd,otpKey,execPath):
    driver = webdriver.Chrome(service=ChromeService(chromeManager),options=chromeOptions)
    driver.get("https://gs.mangot5.com/game/gs")
    loginPageBtn = WebDriverWait(driver, 30).until(ExpectedConditions.presence_of_element_located((By.CLASS_NAME, "logbtn")))
    loginPageBtn.click()

    recaptchaIframe = WebDriverWait(driver, 30).until(ExpectedConditions.presence_of_element_located((By.XPATH,'//iframe[@title="reCAPTCHA"]')))
    driver.find_element(By.NAME,"userID").send_keys(acct)
    driver.find_element(By.NAME,"password").send_keys(pwd)

    driver.switch_to.frame(recaptchaIframe)
    WebDriverWait(driver, 150).until(ExpectedConditions.presence_of_element_located((By.CLASS_NAME, "recaptcha-checkbox-checked")))
    driver.switch_to.default_content()

    loginBtn = WebDriverWait(driver, 10).until(ExpectedConditions.presence_of_element_located((By.ID ,"submitBtn")))
    loginBtn.click()

    otpField = WebDriverWait(driver, 10).until(ExpectedConditions.element_to_be_clickable((By.NAME ,"validCode")))
    totp = pyotp.TOTP(otpKey)
    otpField.send_keys(totp.now())

    submitBtn = WebDriverWait(driver, 10).until(ExpectedConditions.element_to_be_clickable((By.CLASS_NAME ,"btn-submit")))
    submitBtn.click()

    WebDriverWait(driver, 10).until(ExpectedConditions.element_to_be_clickable((By.CLASS_NAME ,"startbutton")))

    jsession = driver.get_cookie("JSESSIONID")['value']
    userNo = driver.find_element(By.NAME, "userNo").get_attribute("value")

    response = requests.post(url="https://gs.mangot5.com/game/gs/getAuthKey.json", data={"userNo":userNo}, cookies={"JSESSIONID": jsession})

    os.popen(execPath + " " + userNo + " " + response.json()["authKey"])

if __name__ == '__main__':
    main()