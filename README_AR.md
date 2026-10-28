# ADINETA Standard v1.0.1

ADINETA أداة مستقلة لنظام Linux x86_64 لاستطلاع شبكات IPv4، من تطوير ELITE LAB Works. استخدمها فقط على الأنظمة والشبكات التي تملكها أو تملك تصريحًا صريحًا لفحصها.

## التثبيت

استخدم مثبت إصدار v1.0.1 الرسمي:

```sh
curl -fsSL https://github.com/elitelab-dev/ADINETA-Releases/releases/download/v1.0.1/install.sh | sh
```

يتطلب المثبت Linux x86_64 وglibc بإصدار 2.34 أو أحدث، وينزّل عبر HTTPS، ويتحقق من SHA-256، ويثبت دون `sudo` داخل `~/.local/share/adineta/1.0.1`. أضف `~/.local/bin` إلى `PATH` عند الحاجة.

## التشغيل

```sh
adineta --help
adineta 127.0.0.1 --ports 1 --transport tcp --report terminal
```

يدعم الإصدار فحوص TCP وUDP والنقل المدمج `both`، والمنافذ والنطاقات المحددة، وتقارير Terminal وJSON وCSV، والمهلات والمحاولات وحدود التزامن، واكتشاف الخدمات المدعوم. إعدادا Quick وFull يعملان عبر TCP فقط؛ أما Custom Scan فيقبل `tcp` أو `udp` أو `both`، وتكون القيمة الافتراضية TCP عند الضغط على Enter.

نص سؤال Custom Scan هو:

```text
Transport (tcp/udp/both) [default: tcp]:
```

## السلامة والاستخدام القانوني

تحقق من الأرشيف قبل فكّه باستخدام بصمة SHA-256 المنشورة مع الإصدار. بصمة أرشيف v1.0.1 موجودة في ملف checksum الخاص بالإصدار.

استخدم ADINETA فقط على الأنظمة أو الشبكات المملوكة لك أو المصرح لك بفحصها صراحةً. قد تتضمن التقارير عناوين ومنافذ وملاحظات خدمات وتوقيتات وبيانات probes. احتفظ بملفات `LICENSE_BINARY.txt` و`THIRD_PARTY_NOTICES.txt` ومجلد `licenses/` مع التوزيعة. راجع [README.md](README.md) للنسخة الإنجليزية و[INSTALL.md](INSTALL.md) لتعليمات التثبيت والتحديث والإزالة.

ADINETA برنامج مملوك، ولا تتضمن هذه التوزيعة الشيفرة المصدرية.
