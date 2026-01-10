# Niri Catppuccin

## Установка

Клонируйте этот репозиторий:

```
git clone https://github.com/37signalsS/niri.git
```

## Установка программного обеспечения

### Пакеты Pacman

```
sudo pacman -S gammastep swaybg swayidle satty cliphist xorg-xwayland wl-clipboard nwg-look slurp swaylock slurp grim waybar wofi xdg-user-dirs xdg-desktop-portal-wlr brightnessctl swaync telegram-desktop tmux libreoffice yazi haruna obs-studio gthumb htop bat ripgrep-all zoxide fzf fish wireguard-tools p7zip docker docker-compose polkit-gnome thefuck krita keepassxc libreoffice-still-ru virtualbox scrcpy android-tools eza git-delta atuin lazygit blueman syncthing yt-dlp fragments kdeconnect network-manager-applet nm-connection-editor trash-cli translate-shell flatpak zed linux-zen linux-zen-headers linux-lts linux-lts-headers wev telegram-desktop gvfs-mtp mtpfs
```

### Пакеты из AUR

```
yay -S onlyoffice-bin lens-bin lazydocker ttf-times-new-roman vscodium-bin ungoogled-chromium-bin archarchive phoenix-arch tuxedo-control-center-bin tuxedo-drivers-dkms yt6801-dkms fresh-editor-bin
```

### Дополнительное программное обеспечение

- [Chaotic-AUR](https://aur.chaotic.cx/docs)

- [Anki](https://apps.ankiweb.net/)

- [Warp Terminal](https://app.warp.dev/get_warp)
  ```
  sudo pacman -U ./<filename>.pkg.tar.zst
  ```
  
- [WaveTerm](https://www.waveterm.dev/download)
  ```
  sudo pacman -U <filename>.pacman
  ```
  
- FreeLens (через Flatpak)
  ```
  flatpak install flathub app.freelens.Freelens
  ```

## Конфигурация

### Настройка терминала

1. Установите Starship prompt:
   ```
   curl -sS https://starship.rs/install.sh | sh
   ```
2. Установите Fish как оболочку по умолчанию:
   ```
   chsh -s /usr/bin/fish
   ```

### Rofi and Wofi

Чтобы удалить определенные приложения из Rofi или Wofi, удалите их `.desktop` файлы из:

- `~/.local/share/applications`
- `/usr/share/applications`

## Энергосбережение

```
sudo pacman -S tlp tlp-rdw powertop tp_smapi acpi_call
sudo systemctl mask systemd-rfkill.service && sudo systemctl mask systemd-rfkill.socket
```

Настройте TLP:
```
micro /etc/tlp.conf
```

Создайте службу Powertop:
```
micro /etc/systemd/system/powertop.service
```
```
[Unit]
Description=Powertop tunings

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/bin/powertop --auto-tune
# Раскомментируйте, если требуется бесперебойная работа USB-устройств.
# ExecStartPost=/bin/sh -c "for i in /sys/bus/usb/devices/*/power/control; do echo on > $i; done"

[Install]
WantedBy=multi-user.target
```

Включите службы:
```
sudo systemctl enable --now tlp.service
sudo systemctl enable --now powertop.service
```

## Информация о системе

| Компонент       | Детали                                                                 |
|-----------------|-------------------------------------------------------------------------|
| Дистрибутив    | [CashyOS](https://cachyos.org/)                                 |
| Оконный менеджер  | [Niri](https://github.com/YaLTeR/niri)                                  |
| Панель состояния      | [Waybar](https://github.com/Alexays/Waybar)                             |
| Запускатель приложений | [Wofi](https://man.archlinux.org/man/wofi)                        |
| Терминал        | [Kitty](https://github.com/kovidgoyal/kitty)                                         |
| Оболочка           | [Fish](https://fishshell.com/)                                          |
| Тема иконок      | [Tela icon theme](https://www.gnome-look.org/p/1279924/)             |
| Тема GTK3      | [Catppuccin GTK Theme](https://www.gnome-look.org/p/1715554)            |
| Тема курсора    | [Bibata Modern Ice](https://www.gnome-look.org/p/1197198)               |
| Шрифт            | [BlexMono](https://www.nerdfonts.com/font-downloads)          |

## Использование Stow

Этот репозиторий использует [GNU Stow](https://www.gnu.org/software/stow/) для управления конфигурационными файлами (дотфайлами). Stow — это менеджер символических ссылок, который упрощает управление файлами конфигураций, создавая символические ссылки из этого репозитория в вашу домашнюю директорию.

#### Установка (создание ссылок)

Чтобы установить конфигурацию для одного пакета (например, `nvim`):
```bash
# Переходит в директорию .dotfiles
cd /home/q/.dotfiles 

# Устанавливает пакет nvim
stow nvim
```
Эта команда создаст символическую ссылку: `/home/q/.dotfiles/nvim/.config/nvim/init.lua` -> `/home/q/.config/nvim/init.lua`.

Чтобы установить несколько пакетов одновременно:
```bash
stow fish kitty tmux
```

#### Удаление ссылок

Чтобы удалить символические ссылки для пакета:
```bash
stow -D nvim
```

#### Пробный запуск (Dry Run)

Крайне полезно перед применением изменений посмотреть, что `stow` собирается сделать, без фактического создания или удаления ссылок. Это помогает избежать конфликтов.
```bash
stow -n nvim
```
Флаг `-n` означает "no action" (без действия).

#### Переустановка (Restow)

Если вы изменили что-то в структуре или ссылки оказались "сломаны", вы можете использовать флаг `-R` (restow), чтобы атомарно удалить старые ссылки и создать новые.
```bash
stow -R nvim
```

### Игнорирование файлов

Файл `.stow-local-ignore` в корне репозитория содержит список файлов и каталогов, которые `stow` должен игнорировать. В данном случае он используется, чтобы `stow` не пытался управлять файлом `README.md` или самим репозиторием `.git`.

## Winapps

Winapps позволяет запускать приложения Windows (например, Microsoft Office) из Linux без использования виртуальных машин, интегрируя их в вашу систему.

### Клонирование репозитория
Клонируйте репозиторий Winapps:
```bash
git clone https://github.com/winapps-org/winapps
```

### Установка зависимостей
Установите необходимые пакеты Pacman:
```bash
sudo pacman -Syu --needed -y curl dialog freerdp git iproute2 libnotify openbsd-netcat
```

### Запуск службы Docker
Убедитесь, что служба Docker запущена:
```bash
sudo systemctl start docker
```

### Редактирование compose.yaml
Отредактируйте `compose.yaml` в соответствии с вашими предпочтениями. Например, вы можете указать путь к пользовательскому образу Windows (например, `/home/q/Win11_24H2_EnglishInternational_x64.iso:/custom.iso`) и настроить учетные данные пользователя, пароли и ресурсы контейнера.

### Запуск контейнера Docker Compose
Запустите контейнер Docker Compose и получите к нему доступ через веб-браузер:
```bash
docker compose --file compose.yaml up
```
Подключитесь через браузер по ссылке: `http://127.0.0.1:8006/`

### Настройка Windows
Установите и настройте все необходимые приложения в вашей виртуальной среде Windows (например, выполните очистку и настройку системы с помощью https://github.com/flick9000/winscript).

### Конфигурация Winapps.conf
Создайте или отредактируйте файл `~/.config/winapps/winapps.conf` со следующим содержимым, настроив его под свои нужды:
```
##################################
#   ФАЙЛ КОНФИГУРАЦИИ WINAPPS   #
##################################

# ИНСТРУКЦИИ
# - Начальные и конечные пробелы игнорируются.
# - Пустые строки игнорируются.
# - Строки, начинающиеся с '#', игнорируются.
# - Все символы после '#' игнорируются.

# [ИМЯ ПОЛЬЗОВАТЕЛЯ WINDOWS]
RDP_USER="MyWindowsUser"

# [ПАРОЛЬ WINDOWS]
# ПРИМЕЧАНИЯ:
# - Если вы используете FreeRDP v3.9.0 или выше, вы *должны* установить пароль
# RDP_PASS="MyWindowsPassword"

# [ДОМЕН WINDOWS]
# ЗНАЧЕНИЕ ПО УМОЛЧАНИЮ: '' (ПУСТО)
# RDP_DOMAIN=""

# [IPV4-АДРЕС WINDOWS]
# ПРИМЕЧАНИЯ:
# - Если используется 'libvirt', 'RDP_IP' будет определен WinApps во время выполнения, если оставить его неуказанным.
# ЗНАЧЕНИЕ ПО УМОЛЧАНИЮ:
# - 'docker': '127.0.0.1'
# - 'podman': '127.0.0.1'
# - 'libvirt': '' (ПУСТО)
RDP_IP="127.0.0.1"

# [ИМЯ VM]
# ПРИМЕЧАНИЯ:
# - Применимо только при использовании 'libvirt'
# - Имя VM libvirt должно совпадать, чтобы WinApps мог определить IP-адрес VM, запустить VM и т.д.
# ЗНАЧЕНИЕ ПО УМОЛЧАНИЮ: 'RDPWindows'
VM_NAME="RDPWindows"

# [БЭКЕНД WINAPPS]
# ЗНАЧЕНИЕ ПО УМОЛЧАНИЮ: 'docker'
# ДОПУСТИМЫЕ ЗНАЧЕНИЯ:
# - 'docker'
# - 'podman'
# - 'libvirt'
# - 'manual'
WAFLAVOR="docker"

# [КОЭФФИЦИЕНТ МАСШТАБИРОВАНИЯ ДИСПЛЕЯ]
# ПРИМЕCHАНИЯ:
# - Если указано неподдерживаемое значение, будет выведено предупреждение.
# - Если указано неподдерживаемое значение, WinApps будет использовать ближайшее поддерживаемое значение.
# ЗНАЧЕНИЕ ПО УМОЛЧАНИЮ: '100'
# ДОПУСТИМЫЕ ЗНАЧЕНИЯ:
# - '100'
# - '140'
# - '180'
RDP_SCALE="100"

# [МОНТИРОВАНИЕ СЪЕМНЫХ ПУТЕЙ ДЛЯ ФАЙЛОВ]
# ПРИМЕЧАНИЯ:
# - По умолчанию `udisks` (который у вас, скорее всего, установлен) использует /run/media для монтирования съемных устройств.
#   Это улучшает совместимость с большинством сред рабочего стола (DE).
# ВНИМАНИЕ: Стандарт иерархии файловой системы (FHS) рекомендует /media. Проверьте конфигурацию вашей системы.
# - Для монтирования устройств вручную вы можете использовать /mnt.
# СПРАВКА: https://wiki.archlinux.org/title/Udisks#Mount_to_/media
REMOVABLE_MEDIA="/run/media"

# [ДОПОЛНИТЕЛЬНЫЕ ФЛАГИ И АРГУМЕНТЫ FREERDP]
# ПРИМЕЧАНИЯ:
# - Вы можете попробовать добавить /network:lan к этим флагам, чтобы повысить производительность, однако у некоторых пользователей возникали проблемы с этим.
#   Если это не работает или не работает без флага, вы можете попробовать добавить /nsc и /gfx.
# ЗНАЧЕНИЕ ПО УМОЛЧАНИЮ: '/cert:tofu /sound /microphone +home-drive'
# ДОПУСТИМЫЕ ЗНАЧЕНИЯ: См. https://github.com/awakecoding/FreeRDP-Manuals/blob/master/User/FreeRDP-User-Manual.markdown
RDP_FLAGS="/cert:tofu /sound /microphone +home-drive"

# [ОТЛАДКА WINAPPS]
# ПРИМЕЧАНИЯ:
# - Создает и дописывает в ~/.local/share/winapps/winapps.log при запуске WinApps.
# ЗНАЧЕНИЕ ПО УМОЛЧАНИЮ: 'true'
# ДОПУСТИМЫЕ ЗНАЧЕНИЯ:
# - 'true'
# - 'false'
DEBUG="true"

# [АВТОМАТИЧЕСКИ ПРИОСТАНАВЛИВАТЬ WINDOWS]
# ПРИМЕЧАНИЯ:
# - В настоящее время НЕ СОВМЕСТИМО с 'manual'.
# ЗНАЧЕНИЕ ПО УМОЛЧАНИЮ: 'off'
# ДОПУСТИМЫЕ ЗНАЧЕНИЯ:
# - 'on'
# - 'off'
AUTOPAUSE="off"

# [ТАЙМ-АУТ АВТОМАТИЧЕСКОЙ ПРИОСТАНОВКИ WINDOWS]
# ПРИМЕЧАНИЯ:
# - Этот параметр определяет продолжительность бездействия, которую следует допускать до автоматической приостановки Windows.
# - Этот параметр игнорируется, если для 'AUTOPAUSE' установлено значение 'off'.
# - Значение должно быть указано в секундах (с точностью до 10 секунд, например, '30', '40', '50' и т.д.).
# - Для сеансов RemoteApp RDP существует обязательная 20-секундная задержка, поэтому минимальное значение, которое можно указать здесь, равно '20'.
# - Источник: https://techcommunity.microsoft.com/t5/security-compliance-and-identity/terminal-services-remoteapp-8482-session-termination-logic/ba-p/246566
# ЗНАЧЕНИЕ ПО УМОЛЧАНИЮ: '300'
# ДОПУСТИМЫЕ ЗНАЧЕНИЯ: >=20
AUTOPAUSE_TIME="300"

# [КОМАНДА FREERDP]
# ПРИМЕЧАНИЯ:
# - WinApps попытается автоматически определить правильную команду для вашей системы.
# ЗНАЧЕНИЕ ПО УМОЛЧАНИЮ: '' (ПУСТО)
# ДОПУСТИМЫЕ ЗНАЧЕНИЯ: Команда, необходимая для запуска FreeRDPv3 в вашей системе (например, 'xfreerdp', 'xfreerdp3' и т.д.).
FREERDP_COMMAND=""

# [ТАЙМ-АУТЫ]
# ПРИМЕЧАНИЯ:
# - Эти параметры управляют различными значениями тайм-аутов в настройке WinApps.
# - Увеличение тайм-аутов необходимо только в случае возникновения соответствующих ошибок.
# - Сначала убедитесь, что вы выполнили все советы по устранению неполадок в сообщении об ошибке.

# ПРОВЕРКА ПОРТА
# - Максимальное время (в секундах) ожидания при проверке, открыт ли порт RDP в Windows.
# - Соответствующая ошибка: "NETWORK CONFIGURATION ERROR" (код выхода 13).
# ЗНАЧЕНИЕ ПО УМОЛЧАНИЮ: '5'
PORT_TIMEOUT="5"

# ТЕСТ СОЕДИНЕНИЯ RDP
# - Максимальное время (в секундах) ожидания при тестировании начального подключения RDP к Windows.
# - Соответствующая ошибка: "REMOTE DESKTOP PROTOCOL FAILURE" (код выхода 14).
# ЗНАЧЕНИЕ ПО УМОЛЧАНИЮ: '30'
RDP_TIMEOUT="160"

# СКАНИРОВАНИЕ ПРИЛОЖЕНИЙ
# - Максимальное время (в секундах) ожидания завершения скрипта, который сканирует установленные приложения в Windows.
# - Соответствующая ошибка: "APPLICATION QUERY FAILURE" (код выхода 15).
# ЗНАЧЕНИЕ ПО УМОЛЧАНИЮ: '60'
APP_SCAN_TIMEOUT="60"

# ЗАГРУЗКА WINDOWS
# - Максимальное время (в секундах) ожидания загрузки виртуальной машины Windows, если она не запущена, перед попыткой запуска приложения.
# ЗНАЧЕНИЕ ПО УМОЛЧАНИЮ: '120'
BOOT_TIMEOUT="120"

# FREERDP RAIL HIDEF
# - Этот параметр управляет значением параметра `hidef`, передаваемого параметру /app команды FreeRDP.
# - Установка этого параметра в 'off' может решить проблемы с смещением окон, связанные с развернутыми окнами.
# ЗНАЧЕНИЕ ПО УМОЛЧАНИЮ: 'on'
HIDEF="off"
```

### Скопируйте compose.yaml и запустите Docker
Скопируйте `compose.yaml` в каталог `.config/winapps` и запустите контейнер:
```bash
cp compose.yaml ~/.config/winapps && docker compose --file ~/.config/winapps/compose.yaml start
```

### Интеграция Winapps
Запустите скрипт для настройки интеграции Winapps в вашу систему и подтвердите все действия, нажав `Enter`:
```bash
./setup.sh
```
