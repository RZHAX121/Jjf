-- ================== نظام المفاتيح ==================
-- ================== نظام المفاتيح ==================
local primary_key = "1"    -- المفتاح الرئيسي
local backup_key  = "RZ-BACKUP-KEY"  -- المفتاح الاحتياطي

-- استخدام gg.prompt للحصول على مفتاح من المستخدم
local input = gg.prompt({"🔐 أدخل مفتاح التفعيل:"}, {}, nil, "text")

-- التحقق من أن المستخدم لم يضغط إلغاء
if input == nil then
    gg.alert("❌ تم الإلغاء.\n\nلم يتم إدخال مفتاح.")
    os.exit()
end

local user_input = input[1]

if user_input ~= primary_key and user_input ~= backup_key then
    gg.alert("❌ المفتاح غير صحيح!\n\nإذا كنت لا تملك مفتاح، تواصل مع @RZSAFE")
    os.exit()
end

-- ================== بداية السكربت ==================

gg.alert("WELCOME TO RZ SAFE")
gg.alert("سيتم نسخ رابط القناه")
gg.copyText("@RZSAFE")

-- الصفحة الرئيسية
function HOME()
    HM1 = gg.choice({
        'BYPASS',
        'ESP',
        'MEMORY',
        '🔙 خروج Exit',
    }, nil, 'RZ SAFE')

    if HM1 == nil then return end
    if HM1 == 1 then antiban() end
    if HM1 == 2 then list1() end
    if HM1 == 3 then list2() end
    if HM1 == 4 then exit() end
end

-- BYPASS FUNCTION
function antiban()
function antiban()
    -- قائمة الباصات
    local bypasses = {
        {lib = "libanogs.so", offset = 0x1423D8, value = "00 20 70 47"},
        {lib = "libanogs.so", offset = 0x147638, value = "00 20 70 47"},
        {lib = "libanogs.so", offset = 0x147270, value = "00 20 70 47"},
        {lib = "libanogs.so", offset = 0x4BF5BC, value = "00 20 70 47"},
        {lib = "libanogs.so", offset = 0x145D94, value = "00 20 70 47"},
        {lib = "libanogs.so", offset = 0x13F4A8, value = "00 20 70 47"},
        {lib = "libanogs.so", offset = 0x143A28, value = "00 20 70 47"},
        {lib = "libanogs.so", offset = 0x147DCC, value = "00 20 70 47"},
        {lib = "libanogs.so", offset = 0x351760, value = "00 20 70 47"},
        {lib = "libanogs.so", offset = 0x393464, value = "00 20 70 47"},
        {lib = "libanort.so", offset = 0x89B00,  value = "00 20 70 47"},
        {lib = "libanort.so", offset = 0x155004, value = "00 20 70 47"},
        {lib = "libanort.so", offset = 0x1556A8, value = "00 20 70 47"},
        {lib = "libanort.so", offset = 0x89D50,  value = "00 20 70 47"},
        {lib = "libanort.so", offset = 0xA3888,  value = "00 20 70 47"},
        {lib = "libanort.so", offset = 0x1A7CE4, value = "00 20 70 47"},
        {lib = "libanort.so", offset = 0x89B10,  value = "00 20 70 47"},
        {lib = "libanort.so", offset = 0x109D2C, value = "00 20 70 47"},
        {lib = "libanort.so", offset = 0x1CE5CC, value = "00 20 70 47"},
        {lib = "libanort.so", offset = 0x89C30,  value = "00 20 70 47"},
        {lib = "libanort.so", offset = 0x1B0E10, value = "00 20 70 47"},
        {lib = "libanort.so", offset = 0x1B1748, value = "00 20 70 47"},
        {lib = "libanort.so", offset = 0x89F60,  value = "00 20 70 47"},
        {lib = "libanort.so", offset = 0x1B16DC, value = "00 20 70 47"},
        {lib = "libanort.so", offset = 0x1C2498, value = "00 20 70 47"},
        {lib = "libanort.so", offset = 0x89B30,  value = "00 20 70 47"},
        {lib = "libanort.so", offset = 0x12FBD83, value = "00 20 70 47"},
        {lib = "libanort.so", offset = 0x1B177C, value = "00 20 70 47"},
        {lib = "libanort.so", offset = 0x89A60,  value = "00 20 70 47"},
        {lib = "libanort.so", offset = 0x9CE90,  value = "00 20 70 47"},
        {lib = "libanort.so", offset = 0x89FA0,  value = "00 20 70 47"},
        {lib = "libanort.so", offset = 0xD9470,  value = "00 20 70 47"},
        {lib = "libanort.so", offset = 0xDD5A0,  value = "00 20 70 47"},
        {lib = "libanort.so", offset = 0x89BD0,  value = "00 20 70 47"},
        {lib = "libanort.so", offset = 0xB7D40,  value = "00 20 70 47"},
        {lib = "libanort.so", offset = 0x89EB0,  value = "00 20 70 47"},
        {lib = "libanort.so", offset = 0x18F798, value = "00 20 70 47"},
        {lib = "libanort.so", offset = 0x18F950, value = "00 20 70 47"},
        {lib = "libanort.so", offset = 0x89C00,  value = "00 20 70 47"},
        {lib = "libanort.so", offset = 0x899E0,  value = "00 20 70 47"},
        {lib = "libanort.so", offset = 0x1A1A30, value = "00 20 70 47"},
        {lib = "libanort.so", offset = 0x1A197C, value = "00 20 70 47"},
        {lib = "libanort.so", offset = 0x89E90,  value = "00 20 70 47"}
    }

    -- دالة لتحويل Hex String إلى DWORD (Endianness)
    local function hexToDword(hex)
        local bytes = {}
        for byte in hex:gmatch("..") do
            table.insert(bytes, tonumber(byte, 16))
        end
        return string.unpack("<I4", string.char(table.unpack(bytes)))
    end

    -- تطبيق الباصات
    for i, bp in ipairs(bypasses) do
        local baseAddr = gg.getSymbolAddress(bp.lib)
        if baseAddr == 0 then
            gg.toast("⚠️ "..bp.lib.." غير محملة")
        else
            local address = baseAddr + bp.offset
            gg.setValues({
                {address = address, flags = gg.TYPE_DWORD, value = hexToDword(bp.value)}
            })
        end
    end

    gg.toast("✅ bypass done!")
end
-- ESP LIST
function list1()
    local NA9 = gg.multiChoice({
        'ESP',
        '╠══➣『خروج 👋back』',
    }, nil, '⁦⁦⁦⁦ESP')

    if NA9 == nil then return end
    if NA9[1] then F1() end
    if NA9[2] then HOME() end
end

-- تعديل ESP
function F1()
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("88.50576019287F;87.27782440186F;-100.91194152832F;1F::13", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
    gg.searchNumber("88.50576019287F;87.27782440186F;1F", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
    gg.getResults(6)
    gg.editAll("1.96875;1.96875;999;1.96875;1.96875;999", gg.TYPE_FLOAT)
    gg.clearResults()
    gg.toast("✅ ESP DONE")
end

-- MEMORY LIST
function list2()
    local ingeamM = gg.multiChoice({
        'No Recoil',
        'HED SHOOT',
        'AIM BOT PC',
        'MAGIC PC',
        'IPAD VIEW',
        '﴿رجوع 🔙﴾',
    }, nil, 'MEMORY ')

    if ingeamM == nil then return end

    if ingeamM[1] then A1() end
    if ingeamM[2] then A2() end
    if ingeamM[3] then A3() end
    if ingeamM[4] then A4() end
    if ingeamM[5] then A5() end
    if ingeamM[6] then HOME() end
end

-- No Recoil
function A1()
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("1,348,759,109;1953067887;1,634,692,166;1,920,287,604::28", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
    gg.searchNumber("1634692166", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
    gg.getResults(1)
    gg.editAll("9999", gg.TYPE_DWORD)
    gg.clearResults()
    gg.toast("✅ No Recoil ✅")
end

-- Head Shoot
function A2()
    gg.clearResults()
    gg.setRanges(gg.REGION_BAD)
    gg.searchNumber("-88.66608428955;26:512", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
    gg.searchNumber("26", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
    gg.getResults(2)
    gg.editAll("-460", gg.TYPE_FLOAT)

    gg.clearResults()
    gg.setRanges(gg.REGION_BAD)
    gg.searchNumber("-88.73961639404;28:512", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
    gg.searchNumber("28", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
    gg.getResults(2)
    gg.editAll("-560", gg.TYPE_FLOAT)

    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("9.201618;30.5;25", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
    gg.searchNumber("25;30.5", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
    gg.getResults(10)
    gg.editAll("300", gg.TYPE_FLOAT)
    gg.clearResults()
    gg.toast("✅ HEAD SHOOT ✅")
end

-- AIM BOT
function A3()
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("3.5;1;200;20::999", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
    gg.searchNumber("3.5;1;200;20", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
    gg.getResults(300)
    gg.editAll("1.0e20", gg.TYPE_FLOAT)
    gg.toast("✅ AIM BOT ✅")
end

-- MAGIC PC
function A4()
    gg.clearResults()
    gg.searchNumber("1;20.51941871643;2.04908943176;-86.45767974854;-92.2311706543;16.0", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
    gg.searchNumber("16", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
    gg.getResults(100)
    gg.editAll("120", gg.TYPE_FLOAT)
    gg.clearResults()

    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("9.20161819458;23;25;30.5", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
    gg.searchNumber("25;30.5", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
    gg.getResults(10)
    gg.editAll("240", gg.TYPE_FLOAT)
    gg.clearResults()
    gg.toast("✅ MAGIC PC ✅")
end

-- IPAD VIEW
function A5()
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("220;178;15 ", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
    gg.searchNumber("220", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
    gg.getResults(300)
    gg.editAll("350", gg.TYPE_FLOAT)
    gg.clearResults()
    gg.toast("✅ IPAD VIEW ✅")
end

-- إنهاء البرنامج
function exit()
    print('⁦BY @RZSAFE')
    gg.skipRestoreState()
    gg.setVisible(true)
    os.exit()
end

-- حلقة البرنامج
while true do
    if gg.isVisible(true) then
        HOME()
        gg.setVisible(false)
    end
    gg.sleep(100)
  end
