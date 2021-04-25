function hue2rgb(p, q, t) {
    if (t < 0) t++
    if (t > 1) t--
    if (t < 1/6) return p + (q - p) * 6 * t
    if (t < 1/2) return q
    if (t < 2/3) return p + (q - p) * 6 * (2/3 - t)
    return p
}

function hsl2rgb(h, s, l) {
    h = h % 360 / 360
    s = s / 100
    l = l / 100

    r = 0
    g = 0
    b = 0

    if (s == 0) {
        r = l
        g = l
        b = l
    } else {

    }
    q = l < 0.5 ? l * (1 + s) : l + s - l * s
    p = 2 * l - q
    r = int(hue2rgb(p, q, h + 1/3) * 255)
    g = int(hue2rgb(p, q, h) * 255)
    b = int(hue2rgb(p, q, h - 1/3) * 255)
    return sprintf("%d;%d;%d", r, g, b)
}

BEGIN {
    cmd = "tput cols"$1; cmd | getline cols; close(cmd)
    token = "━"
    fstr = ""
    h = 0
    for (i = 0; i < cols; i++) {
        fstr = sprintf("%s\033[38;2;%sm%s", fstr, hsl2rgb(h, 100, 50), token)
        h += 360 / cols
    }
    print fstr
}