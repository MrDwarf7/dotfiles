--- @since 25.2.26

local FILES = {
	[".envrc"] = "text/plain",
	[".gitconfig"] = "text/plain",
	[".gitignore"] = "text/plain",
	[".luacheckrc"] = "text/lua",
	[".npmrc"] = "text/plain",
	[".styluaignore"] = "text/plain",
	[".zshenv"] = "text/plain",
	[".zshrc"] = "text/plain",
	["cargo.lock"] = "application/json",
	["flake.lock"] = "application/json",
	license = "text/plain",
}

local EXTS = {
	["123"] = "application/lotus-1-2-3",
	["3dml"] = "text/in3d.3dml",
	["3ds"] = "image/3ds",
	["3g2"] = "video/3gpp2",
	["3gp"] = "video/3gpp",
	["7z"] = "application/7z-compressed",
	["for"] = "text/fortran",
	["in"] = "text/plain",
	["n-gage"] = "application/nokia.n-gage.symbian.install",
	["sfd-hdstx"] = "application/hydrostatix.sof-data",
	aab = "application/authorware-bin",
	aac = "audio/aac",
	aam = "application/authorware-map",
	aas = "application/authorware-seg",
	abw = "application/abiword",
	ac = "application/pkix-attr-cert",
	acc = "application/americandynamics.acc",
	ace = "application/ace-compressed",
	acu = "application/acucobol",
	acutc = "application/acucorp",
	adp = "audio/adpcm",
	aep = "application/audiograph",
	afm = "application/font-type1",
	afp = "application/ibm.modcap",
	ahead = "application/ahead.space",
	ai = "application/postscript",
	aif = "audio/aiff",
	aifc = "audio/aiff",
	aiff = "audio/aiff",
	air = "application/adobe.air-application-installer-package+zip",
	ait = "application/dvb.ait",
	ami = "application/amiga.ami",
	apk = "application/android.package-archive",
	appcache = "text/cache-manifest",
	application = "application/ms-application",
	apr = "application/lotus-approach",
	arc = "application/freearc",
	asc = "application/pgp-signature",
	asf = "video/ms-asf",
	asm = "text/asm",
	aso = "application/accpac.simply.aso",
	ass = "text/ass",
	asx = "video/ms-asf",
	atc = "application/acucorp",
	atom = "application/atom+xml",
	atomcat = "application/atomcat+xml",
	atomsvc = "application/atomsvc+xml",
	atx = "application/antix.game-component",
	au = "audio/basic",
	avi = "video/msvideo",
	avif = "image/avif",
	aw = "application/applixware",
	azf = "application/airzip.filesecure.azf",
	azs = "application/airzip.filesecure.azs",
	azw = "application/amazon.ebook",
	bash = "text/shellscript",
	bat = "application/msdownload",
	bcpio = "application/bcpio",
	bdf = "application/font-bdf",
	bdm = "application/syncml.dm+wbxml",
	bean = "text/plain",
	beancount = "text/plain",
	bed = "application/realvnc.bed",
	bh2 = "application/fujitsu.oasysprs",
	bin = "application/octet-stream",
	blb = "application/blorb",
	blorb = "application/blorb",
	bmi = "application/bmi",
	bmp = "image/bmp",
	book = "application/framemaker",
	box = "application/previewsystems.box",
	boz = "application/bzip2",
	bpk = "application/octet-stream",
	btif = "image/prs.btif",
	bz = "application/bzip",
	bz2 = "application/bzip2",
	c = "text/c",
	c11amc = "application/cluetrust.cartomobile-config",
	c11amz = "application/cluetrust.cartomobile-config-pkg",
	c4d = "application/clonk.c4group",
	c4f = "application/clonk.c4group",
	c4g = "application/clonk.c4group",
	c4p = "application/clonk.c4group",
	c4u = "application/clonk.c4group",
	cab = "application/ms-cab-compressed",
	caf = "audio/caf",
	cap = "application/tcpdump.pcap",
	car = "application/curl.car",
	cat = "application/ms-pki.seccat",
	cb7 = "application/cbr",
	cba = "application/cbr",
	cbr = "application/cbr",
	cbt = "application/cbr",
	cbz = "application/cbr",
	cc = "text/c",
	cct = "application/director",
	ccxml = "application/ccxml+xml",
	cdbcmsg = "application/contact.cmsg",
	cdf = "application/netcdf",
	cdkey = "application/mediastation.cdkey",
	cdmia = "application/cdmi-capability",
	cdmic = "application/cdmi-container",
	cdmid = "application/cdmi-domain",
	cdmio = "application/cdmi-object",
	cdmiq = "application/cdmi-queue",
	cdx = "chemical/cdx",
	cdxml = "application/chemdraw+xml",
	cdy = "application/cinderella",
	cer = "application/pkix-cert",
	cfg = "text/plain",
	cfs = "application/cfs-compressed",
	cgm = "image/cgm",
	chat = "application/chat",
	chm = "application/ms-htmlhelp",
	chrt = "application/kde.kchart",
	cif = "chemical/cif",
	cii = "application/anser-web-certificate-issue-initiation",
	cil = "application/ms-artgalry",
	cla = "application/claymore",
	class = "application/java-vm",
	clkk = "application/crick.clicker.keyboard",
	clkp = "application/crick.clicker.palette",
	clkt = "application/crick.clicker.template",
	clkw = "application/crick.clicker.wordbank",
	clkx = "application/crick.clicker",
	clp = "application/msclip",
	cmc = "application/cosmocaller",
	cmdf = "chemical/cmdf",
	cml = "chemical/cml",
	cmp = "application/yellowriver-custom-menu",
	cmx = "image/cmx",
	cod = "application/rim.cod",
	com = "application/msdownload",
	conf = "text/plain",
	cpio = "application/cpio",
	cpp = "text/c",
	cpt = "application/mac-compactpro",
	crd = "application/mscardfile",
	crl = "application/pkix-crl",
	crt = "application/x509-ca-cert",
	cryptonote = "application/rig.cryptonote",
	csh = "application/csh",
	csml = "chemical/csml",
	csp = "application/commonspace",
	css = "text/css",
	cst = "application/director",
	csv = "text/csv",
	cu = "application/cu-seeme",
	curl = "text/curl",
	cww = "application/prs.cww",
	cxt = "application/director",
	cxx = "text/c",
	dae = "model/collada+xml",
	daf = "application/mobius.daf",
	dart = "application/dart",
	dataless = "application/fdsn.seed",
	davmount = "application/davmount+xml",
	dbk = "application/docbook+xml",
	dcr = "application/director",
	dcurl = "text/curl.dcurl",
	dd2 = "application/oma.dd2+xml",
	ddd = "application/fujixerox.ddd",
	deb = "application/debian-package",
	def = "text/plain",
	deploy = "application/octet-stream",
	der = "application/x509-ca-cert",
	dfac = "application/dreamfactory",
	dgc = "application/dgc-compressed",
	dic = "text/c",
	dir = "application/director",
	dis = "application/mobius.dis",
	dist = "application/octet-stream",
	distz = "application/octet-stream",
	djv = "image/djvu",
	djvu = "image/djvu",
	dll = "application/msdownload",
	dmg = "application/apple-diskimage",
	dmp = "application/tcpdump.pcap",
	dms = "application/octet-stream",
	dna = "application/dna",
	doc = "application/msword",
	docm = "application/ms-word.document.macroenabled.12",
	docx = "application/openxmlformats-officedocument.wordprocessingml.document",
	dot = "application/msword",
	dotm = "application/ms-word.template.macroenabled.12",
	dotx = "application/openxmlformats-officedocument.wordprocessingml.template",
	dp = "application/osgi.dp",
	dpg = "application/dpgraph",
	dra = "audio/dra",
	dsc = "text/prs.lines.tag",
	dssc = "application/dssc+der",
	dtb = "application/dtbook+xml",
	dtd = "application/xml-dtd",
	dts = "audio/dts",
	dtshd = "audio/dts.hd",
	dump = "application/octet-stream",
	dvb = "video/dvb.file",
	dvi = "application/dvi",
	dwf = "model/dwf",
	dwg = "image/dwg",
	dxf = "image/dxf",
	dxp = "application/spotfire.dxp",
	dxr = "application/director",
	ebuild = "application/gentoo.ebuild",
	ecelp4800 = "audio/nuera.ecelp4800",
	ecelp7470 = "audio/nuera.ecelp7470",
	ecelp9600 = "audio/nuera.ecelp9600",
	eclass = "application/gentoo.eclass",
	ecma = "application/ecmascript",
	edm = "application/novadigm.edm",
	edx = "application/novadigm.edx",
	efif = "application/picsel",
	ei6 = "application/pg.osasli",
	elc = "application/octet-stream",
	emf = "application/msmetafile",
	eml = "message/rfc822",
	emma = "application/emma+xml",
	emz = "application/msmetafile",
	env = "text/plain",
	eol = "audio/digital-winds",
	eot = "application/ms-fontobject",
	eps = "application/postscript",
	epub = "application/epub+zip",
	es3 = "application/eszigno3+xml",
	esa = "application/osgi.subsystem",
	esf = "application/epson.esf",
	et3 = "application/eszigno3+xml",
	etx = "text/setext",
	eva = "application/eva",
	evy = "application/envoy",
	exe = "application/msdownload",
	exi = "application/exi",
	ext = "application/novadigm.ext",
	ez = "application/andrew-inset",
	ez2 = "application/ezpix-album",
	ez3 = "application/ezpix-package",
	f = "text/fortran",
	f4v = "video/f4v",
	f77 = "text/fortran",
	f90 = "text/fortran",
	fbs = "image/fastbidsheet",
	fcdt = "application/adobe.formscentral.fcdt",
	fcs = "application/isac.fcs",
	fdf = "application/fdf",
	fe_launch = "application/denovo.fcselayout-link",
	fg5 = "application/fujitsu.oasysgp",
	fgd = "application/director",
	fh = "image/freehand",
	fh4 = "image/freehand",
	fh5 = "image/freehand",
	fh7 = "image/freehand",
	fhc = "image/freehand",
	fig = "application/xfig",
	fish = "text/shellscript",
	flac = "audio/flac",
	fli = "video/fli",
	flo = "application/micrografx.flo",
	flv = "video/flv",
	flw = "application/kde.kivio",
	flx = "text/fmi.flexstor",
	fly = "text/fly",
	fm = "application/framemaker",
	fnc = "application/frogans.fnc",
	fpx = "image/fpx",
	frame = "application/framemaker",
	fsc = "application/fsc.weblaunch",
	fst = "image/fst",
	ftc = "application/fluxtime.clip",
	fti = "application/anser-web-funds-transfer-initiation",
	fvt = "video/fvt",
	fxp = "application/adobe.fxp",
	fxpl = "application/adobe.fxp",
	fzs = "application/fuzzysheet",
	g2w = "application/geoplan",
	g3 = "image/g3fax",
	g3w = "application/geospace",
	gac = "application/groove-account",
	gam = "application/tads",
	gbr = "application/rpki-ghostbusters",
	gca = "application/gca-compressed",
	gdl = "model/gdl",
	geo = "application/dynageo",
	gex = "application/geometry-explorer",
	ggb = "application/geogebra.file",
	ggs = "application/geogebra.slides",
	ggt = "application/geogebra.tool",
	ghf = "application/groove-help",
	gif = "image/gif",
	gim = "application/groove-identity-message",
	gml = "application/gml+xml",
	gmx = "application/gmx",
	gnumeric = "application/gnumeric",
	go = "text/go",
	gph = "application/flographit",
	gpx = "application/gpx+xml",
	gqf = "application/grafeq",
	gqs = "application/grafeq",
	gram = "application/srgs",
	gramps = "application/gramps-xml",
	gre = "application/geometry-explorer",
	grv = "application/groove-injector",
	grxml = "application/srgs+xml",
	gsf = "application/font-ghostscript",
	gtar = "application/gtar",
	gtm = "application/groove-tool-message",
	gtw = "model/gtw",
	gv = "text/graphviz",
	gxf = "application/gxf",
	gxt = "application/geonext",
	h = "text/c",
	h261 = "video/h261",
	h263 = "video/h263",
	h264 = "video/h264",
	hal = "application/hal+xml",
	hbci = "application/hbci",
	hcl = "text/hcl",
	hdf = "application/hdf",
	hh = "text/c",
	hlp = "application/winhlp",
	hpgl = "application/hp-hpgl",
	hpid = "application/hp-hpid",
	hpp = "text/c",
	hps = "application/hp-hps",
	hqx = "application/mac-binhex40",
	htke = "application/kenameaapp",
	htm = "text/html",
	html = "text/html",
	hvd = "application/yamaha.hv-dic",
	hvp = "application/yamaha.hv-voice",
	hvs = "application/yamaha.hv-script",
	i2g = "application/intergeo",
	icc = "application/iccprofile",
	ice = "conference/cooltalk",
	icm = "application/iccprofile",
	ico = "image/icon",
	ics = "text/calendar",
	ief = "image/ief",
	ifb = "text/calendar",
	ifm = "application/shana.informed.formdata",
	iges = "model/iges",
	igl = "application/igloader",
	igm = "application/insors.igm",
	igs = "model/iges",
	igx = "application/micrografx.igx",
	iif = "application/shana.informed.interchange",
	imp = "application/accpac.simply.imp",
	ims = "application/ms-ims",
	ini = "text/plain",
	ink = "application/inkml+xml",
	inkml = "application/inkml+xml",
	install = "application/install-instructions",
	iota = "application/astraea-software.iota",
	ipfix = "application/ipfix",
	ipk = "application/shana.informed.package",
	irm = "application/ibm.rights-management",
	irp = "application/irepository.package+xml",
	iso = "application/iso9660-image",
	itp = "application/shana.informed.formtemplate",
	ivp = "application/immervision-ivp",
	ivu = "application/immervision-ivu",
	jad = "text/sun.j2me.app-descriptor",
	jam = "application/jam",
	jar = "application/java-archive",
	java = "text/java-source",
	jisp = "application/jisp",
	jlt = "application/hp-jlyt",
	jnlp = "application/java-jnlp-file",
	joda = "application/joost.joda-archive",
	jpe = "image/jpeg",
	jpeg = "image/jpeg",
	jpg = "image/jpeg",
	jpgm = "video/jpm",
	jpgv = "video/jpeg",
	jpm = "video/jpm",
	js = "text/javascript",
	json = "application/json",
	jsonc = "application/json",
	jsonml = "application/jsonml+json",
	jsx = "text/jsx",
	jxl = "image/jxl",
	kar = "audio/midi",
	karbon = "application/kde.karbon",
	kfo = "application/kde.kformula",
	kia = "application/kidspiration",
	kml = "application/google-earth.kml+xml",
	kmz = "application/google-earth.kmz",
	kne = "application/kinar",
	knp = "application/kinar",
	kon = "application/kde.kontour",
	kpr = "application/kde.kpresenter",
	kpt = "application/kde.kpresenter",
	kpxx = "application/ds-keypoint",
	ksp = "application/kde.kspread",
	ktr = "application/kahootz",
	ktx = "image/ktx",
	ktz = "application/kahootz",
	kwd = "application/kde.kword",
	kwt = "application/kde.kword",
	lasxml = "application/las.las+xml",
	latex = "application/latex",
	lbd = "application/llamagraphics.life-balance.desktop",
	lbe = "application/llamagraphics.life-balance.exchange+xml",
	les = "application/hhe.lesson-player",
	lha = "application/lzh-compressed",
	link66 = "application/route66.link66+xml",
	list = "text/plain",
	list3820 = "application/ibm.modcap",
	listafp = "application/ibm.modcap",
	lnk = "application/ms-shortcut",
	log = "text/plain",
	lostxml = "application/lost+xml",
	lrf = "application/octet-stream",
	lrm = "application/ms-lrm",
	ltf = "application/frogans.ltf",
	lua = "text/lua",
	lvp = "audio/lucent.voice",
	lwp = "application/lotus-wordpro",
	lzh = "application/lzh-compressed",
	m13 = "application/msmediaview",
	m14 = "application/msmediaview",
	m1v = "video/mpeg",
	m21 = "application/mp21",
	m2a = "audio/mpeg",
	m2t = "video/mp2t",
	m2ts = "video/mp2t",
	m2v = "video/mpeg",
	m3a = "audio/mpeg",
	m3u = "audio/mpegurl",
	m3u8 = "application/apple.mpegurl",
	m4a = "audio/mp4",
	m4u = "video/mpegurl",
	m4v = "video/m4v",
	ma = "application/mathematica",
	mads = "application/mads+xml",
	mag = "application/ecowin.chart",
	maker = "application/framemaker",
	man = "text/troff",
	mar = "application/octet-stream",
	mathml = "application/mathml+xml",
	mb = "application/mathematica",
	mbk = "application/mobius.mbk",
	mbox = "application/mbox",
	mc1 = "application/medcalcdata",
	mcd = "application/mcd",
	mcurl = "text/curl.mcurl",
	md = "text/markdown",
	mdb = "application/msaccess",
	mdi = "image/ms-modi",
	me = "text/troff",
	mesh = "model/mesh",
	meta4 = "application/metalink4+xml",
	metalink = "application/metalink+xml",
	mets = "application/mets+xml",
	mfm = "application/mfmp",
	mft = "application/rpki-manifest",
	mgp = "application/osgeo.mapguide.package",
	mgz = "application/proteus.magazine",
	mid = "audio/midi",
	midi = "audio/midi",
	mie = "application/mie",
	mif = "application/mif",
	mime = "message/rfc822",
	mj2 = "video/mj2",
	mjp2 = "video/mj2",
	mjs = "text/javascript",
	mk3d = "video/matroska",
	mka = "audio/matroska",
	mks = "video/matroska",
	mkv = "video/matroska",
	mlp = "application/dolby.mlp",
	mmd = "application/chipnuts.karaoke-mmd",
	mmf = "application/smaf",
	mmr = "image/fujixerox.edmics-mmr",
	mng = "video/mng",
	mny = "application/msmoney",
	mobi = "application/mobipocket-ebook",
	mods = "application/mods+xml",
	mov = "video/quicktime",
	movie = "video/sgi-movie",
	mp2 = "audio/mpeg",
	mp21 = "application/mp21",
	mp2a = "audio/mpeg",
	mp3 = "audio/mpeg",
	mp4 = "video/mp4",
	mp4a = "audio/mp4",
	mp4s = "application/mp4",
	mp4v = "video/mp4",
	mpc = "application/mophun.certificate",
	mpe = "video/mpeg",
	mpeg = "video/mpeg",
	mpg = "video/mpeg",
	mpg4 = "video/mp4",
	mpga = "audio/mpeg",
	mpkg = "application/apple.installer+xml",
	mpm = "application/blueice.multipass",
	mpn = "application/mophun.application",
	mpp = "application/ms-project",
	mpt = "application/ms-project",
	mpy = "application/ibm.minipay",
	mqy = "application/mobius.mqy",
	mrc = "application/marc",
	mrcx = "application/marcxml+xml",
	ms = "text/troff",
	mscml = "application/mediaservercontrol+xml",
	mseed = "application/fdsn.mseed",
	mseq = "application/mseq",
	msf = "application/epson.msf",
	msh = "model/mesh",
	msi = "application/msdownload",
	msl = "application/mobius.msl",
	msty = "application/muvee.style",
	mts = "video/mp2t",
	mus = "application/musician",
	musicxml = "application/recordare.musicxml+xml",
	mvb = "application/msmediaview",
	mwf = "application/mfer",
	mxf = "application/mxf",
	mxl = "application/recordare.musicxml",
	mxml = "application/xv+xml",
	mxs = "application/triscape.mxs",
	mxu = "video/mpegurl",
	n3 = "text/n3",
	nb = "application/mathematica",
	nbp = "application/wolfram.player",
	nc = "application/netcdf",
	ncx = "application/dtbncx+xml",
	nfo = "text/nfo",
	ngdat = "application/nokia.n-gage.data",
	nitf = "application/nitf",
	nix = "text/nix",
	nlu = "application/neurolanguage.nlu",
	nml = "application/enliven",
	nnd = "application/noblenet-directory",
	nns = "application/noblenet-sealer",
	nnw = "application/noblenet-web",
	npx = "image/net-fpx",
	nsc = "application/conference",
	nsf = "application/lotus-notes",
	ntf = "application/nitf",
	nzb = "application/nzb",
	oa2 = "application/fujitsu.oasys2",
	oa3 = "application/fujitsu.oasys3",
	oas = "application/fujitsu.oasys",
	obd = "application/msbinder",
	obj = "application/tgif",
	oda = "application/oda",
	odb = "application/oasis.opendocument.database",
	odc = "application/oasis.opendocument.chart",
	odf = "application/oasis.opendocument.formula",
	odft = "application/oasis.opendocument.formula-template",
	odg = "application/oasis.opendocument.graphics",
	odi = "application/oasis.opendocument.image",
	odm = "application/oasis.opendocument.text-master",
	odp = "application/oasis.opendocument.presentation",
	ods = "application/oasis.opendocument.spreadsheet",
	odt = "application/oasis.opendocument.text",
	oga = "audio/ogg",
	ogg = "audio/ogg",
	ogv = "video/ogg",
	ogx = "application/ogg",
	omdoc = "application/omdoc+xml",
	onepkg = "application/onenote",
	onetmp = "application/onenote",
	onetoc = "application/onenote",
	onetoc2 = "application/onenote",
	opf = "application/oebps-package+xml",
	opml = "text/opml",
	oprc = "application/palm",
	opus = "audio/ogg",
	org = "application/lotus-organizer",
	osf = "application/yamaha.openscoreformat",
	osfpvg = "application/yamaha.openscoreformat.osfpvg+xml",
	otc = "application/oasis.opendocument.chart-template",
	otf = "font/otf",
	otg = "application/oasis.opendocument.graphics-template",
	oth = "application/oasis.opendocument.text-web",
	oti = "application/oasis.opendocument.image-template",
	otp = "application/oasis.opendocument.presentation-template",
	ots = "application/oasis.opendocument.spreadsheet-template",
	ott = "application/oasis.opendocument.text-template",
	oxps = "application/oxps",
	oxt = "application/openofficeorg.extension",
	p = "text/pascal",
	p10 = "application/pkcs10",
	p12 = "application/pkcs12",
	p7b = "application/pkcs7-certificates",
	p7c = "application/pkcs7-mime",
	p7m = "application/pkcs7-mime",
	p7r = "application/pkcs7-certreqresp",
	p7s = "application/pkcs7-signature",
	p8 = "application/pkcs8",
	pas = "text/pascal",
	patch = "text/diff",
	paw = "application/pawaafile",
	pbd = "application/powerbuilder6",
	pbm = "image/portable-bitmap",
	pcap = "application/tcpdump.pcap",
	pcf = "application/font-pcf",
	pcl = "application/hp-pcl",
	pclxl = "application/hp-pclxl",
	pct = "image/pict",
	pcurl = "application/curl.pcurl",
	pcx = "image/pcx",
	pdb = "application/palm",
	pdf = "application/pdf",
	pfa = "application/font-type1",
	pfb = "application/font-type1",
	pfm = "application/font-type1",
	pfr = "application/font-tdpfr",
	pfx = "application/pkcs12",
	pgm = "image/portable-graymap",
	pgn = "application/chess-pgn",
	pgp = "application/pgp-encrypted",
	php = "text/php",
	pic = "image/pict",
	pkg = "application/octet-stream",
	pki = "application/pkixcmp",
	pkipath = "application/pkix-pkipath",
	plb = "application/3gpp.pic-bw-large",
	plc = "application/mobius.plc",
	plf = "application/pocketlearn",
	pls = "application/pls+xml",
	pml = "application/ctc-posml",
	png = "image/png",
	pnm = "image/portable-anymap",
	portpkg = "application/macports.portpkg",
	pot = "application/ms-powerpoint",
	potm = "application/ms-powerpoint.template.macroenabled.12",
	potx = "application/openxmlformats-officedocument.presentationml.template",
	ppam = "application/ms-powerpoint.addin.macroenabled.12",
	ppd = "application/cups-ppd",
	ppm = "image/portable-pixmap",
	pps = "application/ms-powerpoint",
	ppsm = "application/ms-powerpoint.slideshow.macroenabled.12",
	ppsx = "application/openxmlformats-officedocument.presentationml.slideshow",
	ppt = "application/ms-powerpoint",
	pptm = "application/ms-powerpoint.presentation.macroenabled.12",
	pptx = "application/openxmlformats-officedocument.presentationml.presentation",
	pqa = "application/palm",
	prc = "application/mobipocket-ebook",
	pre = "application/lotus-freelance",
	prf = "application/pics-rules",
	ps = "application/postscript",
	psb = "application/3gpp.pic-bw-small",
	psd = "image/adobe.photoshop",
	psf = "application/font-linux-psf",
	pskcxml = "application/pskc+xml",
	ptid = "application/pvi.ptid1",
	pub = "application/mspublisher",
	pvb = "application/3gpp.pic-bw-var",
	pwn = "application/3m.post-it-notes",
	py = "text/python",
	pya = "audio/ms-playready.media.pya",
	pyv = "video/ms-playready.media.pyv",
	qam = "application/epson.quickanime",
	qbo = "application/intu.qbo",
	qfx = "application/intu.qfx",
	qml = "text/qml",
	qps = "application/publishare-delta-tree",
	qt = "video/quicktime",
	qwd = "application/quark.quarkxpress",
	qwt = "application/quark.quarkxpress",
	qxb = "application/quark.quarkxpress",
	qxd = "application/quark.quarkxpress",
	qxl = "application/quark.quarkxpress",
	qxt = "application/quark.quarkxpress",
	r = "text/r",
	ra = "audio/pn-realaudio",
	ram = "audio/pn-realaudio",
	rar = "application/rar",
	ras = "image/cmu-raster",
	rb = "text/ruby",
	rcprofile = "application/ipunplugged.rcprofile",
	rdf = "application/rdf+xml",
	rdz = "application/data-vision.rdz",
	rep = "application/businessobjects",
	res = "application/dtbresource+xml",
	rgb = "image/rgb",
	rif = "application/reginfo+xml",
	rip = "audio/rip",
	ris = "application/research-info-systems",
	rl = "application/resource-lists+xml",
	rlc = "image/fujixerox.edmics-rlc",
	rld = "application/resource-lists-diff+xml",
	rm = "application/rn-realmedia",
	rmi = "audio/midi",
	rmp = "audio/pn-realaudio-plugin",
	rms = "application/jcp.javame.midlet-rms",
	rmvb = "application/rn-realmedia-vbr",
	rnc = "application/relax-ng-compact-syntax",
	roa = "application/rpki-roa",
	roff = "text/troff",
	rp9 = "application/cloanto.rp9",
	rpm = "application/rpm",
	rpss = "application/nokia.radio-presets",
	rpst = "application/nokia.radio-preset",
	rq = "application/sparql-query",
	rs = "text/rust",
	rsd = "application/rsd+xml",
	rss = "application/rss+xml",
	rtf = "application/rtf",
	rtx = "text/richtext",
	s = "text/asm",
	s3m = "audio/s3m",
	saf = "application/yamaha.smaf-audio",
	sbml = "application/sbml+xml",
	sc = "application/ibm.secure-container",
	scd = "application/msschedule",
	scm = "application/lotus-screencam",
	scq = "application/scvp-cv-request",
	scs = "application/scvp-cv-response",
	scss = "text/scss",
	scurl = "text/curl.scurl",
	sda = "application/stardivision.draw",
	sdc = "application/stardivision.calc",
	sdd = "application/stardivision.impress",
	sdkd = "application/solent.sdkm+xml",
	sdkm = "application/solent.sdkm+xml",
	sdp = "application/sdp",
	sdw = "application/stardivision.writer",
	see = "application/seemail",
	seed = "application/fdsn.seed",
	sema = "application/sema",
	semd = "application/semd",
	semf = "application/semf",
	ser = "application/java-serialized-object",
	setpay = "application/set-payment-initiation",
	setreg = "application/set-registration-initiation",
	sfs = "application/spotfire.sfs",
	sfv = "text/sfv",
	sgi = "image/sgi",
	sgl = "application/stardivision.writer-global",
	sgm = "text/sgml",
	sgml = "text/sgml",
	sh = "text/shellscript",
	shar = "application/shar",
	shf = "application/shf+xml",
	sid = "image/mrsid-image",
	sig = "application/pgp-signature",
	sil = "audio/silk",
	silo = "model/mesh",
	sis = "application/symbian.install",
	sisx = "application/symbian.install",
	sit = "application/stuffit",
	sitx = "application/stuffitx",
	skd = "application/koan",
	skm = "application/koan",
	skp = "application/koan",
	skt = "application/koan",
	sldm = "application/ms-powerpoint.slide.macroenabled.12",
	sldx = "application/openxmlformats-officedocument.presentationml.slide",
	slt = "application/epson.salt",
	sm = "application/stepmania.stepchart",
	smf = "application/stardivision.math",
	smi = "application/smil+xml",
	smil = "application/smil+xml",
	smv = "video/smv",
	smzip = "application/stepmania.package",
	snd = "audio/basic",
	snf = "application/font-snf",
	so = "application/octet-stream",
	spc = "application/pkcs7-certificates",
	spf = "application/yamaha.smaf-phrase",
	spl = "application/futuresplash",
	spot = "text/in3d.spot",
	spp = "application/scvp-vp-response",
	spq = "application/scvp-vp-request",
	spx = "audio/ogg",
	sql = "application/sql",
	src = "application/wais-source",
	srt = "application/subrip",
	sru = "application/sru+xml",
	srx = "application/sparql-results+xml",
	ssdl = "application/ssdl+xml",
	sse = "application/kodak-descriptor",
	ssf = "application/epson.ssf",
	ssml = "application/ssml+xml",
	st = "application/sailingtracker.track",
	stc = "application/sun.xml.calc.template",
	std = "application/sun.xml.draw.template",
	stf = "application/wt.stf",
	sti = "application/sun.xml.impress.template",
	stk = "application/hyperstudio",
	stl = "application/ms-pki.stl",
	str = "application/pg.format",
	stw = "application/sun.xml.writer.template",
	sub = "text/dvb.subtitle",
	sus = "application/sus-calendar",
	susp = "application/sus-calendar",
	sv4cpio = "application/sv4cpio",
	sv4crc = "application/sv4crc",
	svc = "application/dvb.service",
	svd = "application/svd",
	svg = "image/svg+xml",
	svgz = "image/svg+xml",
	swa = "application/director",
	swf = "application/shockwave-flash",
	swi = "application/aristanetworks.swi",
	sxc = "application/sun.xml.calc",
	sxd = "application/sun.xml.draw",
	sxg = "application/sun.xml.writer.global",
	sxi = "application/sun.xml.impress",
	sxm = "application/sun.xml.math",
	sxw = "application/sun.xml.writer",
	t = "text/troff",
	t3 = "application/t3vm-image",
	taglet = "application/mynfc",
	tao = "application/tao.intent-module-archive",
	tar = "application/tar",
	tcap = "application/3gpp2.tcap",
	tcl = "application/tcl",
	teacher = "application/smart.teacher",
	tei = "application/tei+xml",
	teicorpus = "application/tei+xml",
	tex = "application/tex",
	texi = "application/texinfo",
	texinfo = "application/texinfo",
	text = "text/plain",
	tf = "text/hcl",
	tfi = "application/thraud+xml",
	tfm = "application/tex-tfm",
	tfrc = "text/hcl",
	tfstate = "application/json",
	tfvars = "text/hcl",
	tga = "image/tga",
	thmx = "application/ms-officetheme",
	tif = "image/tiff",
	tiff = "image/tiff",
	tmo = "application/tmobile-livetv",
	toml = "text/toml",
	torrent = "application/bittorrent",
	tpl = "application/groove-tool-template",
	tpt = "application/trid.tpt",
	tr = "text/troff",
	tra = "application/trueapp",
	trm = "application/msterminal",
	ts = "text/typescript",
	tsd = "application/timestamped-data",
	tsv = "text/tab-separated-values",
	tsx = "text/tsx",
	ttc = "font/collection",
	ttf = "font/ttf",
	ttl = "text/turtle",
	twd = "application/simtech-mindmapper",
	twds = "application/simtech-mindmapper",
	txd = "application/genomatix.tuxedo",
	txf = "application/mobius.txf",
	txt = "text/plain",
	u32 = "application/authorware-bin",
	udeb = "application/debian-package",
	ufd = "application/ufdl",
	ufdl = "application/ufdl",
	ulx = "application/glulx",
	umj = "application/umajin",
	unityweb = "application/unity",
	uoml = "application/uoml+xml",
	uri = "text/uri-list",
	uris = "text/uri-list",
	urls = "text/uri-list",
	ustar = "application/ustar",
	utz = "application/uiq.theme",
	uu = "text/uuencode",
	uva = "audio/dece.audio",
	uvd = "application/dece.data",
	uvf = "application/dece.data",
	uvg = "image/dece.graphic",
	uvh = "video/dece.hd",
	uvi = "image/dece.graphic",
	uvm = "video/dece.mobile",
	uvp = "video/dece.pd",
	uvs = "video/dece.sd",
	uvt = "application/dece.ttml+xml",
	uvu = "video/uvvu.mp4",
	uvv = "video/dece.video",
	uvva = "audio/dece.audio",
	uvvd = "application/dece.data",
	uvvf = "application/dece.data",
	uvvg = "image/dece.graphic",
	uvvh = "video/dece.hd",
	uvvi = "image/dece.graphic",
	uvvm = "video/dece.mobile",
	uvvp = "video/dece.pd",
	uvvs = "video/dece.sd",
	uvvt = "application/dece.ttml+xml",
	uvvu = "video/uvvu.mp4",
	uvvv = "video/dece.video",
	uvvx = "application/dece.unspecified",
	uvvz = "application/dece.zip",
	uvx = "application/dece.unspecified",
	uvz = "application/dece.zip",
	vcard = "text/vcard",
	vcd = "application/cdlink",
	vcf = "text/vcard",
	vcg = "application/groove-vcard",
	vcs = "text/vcalendar",
	vcx = "application/vcx",
	vis = "application/visionary",
	viv = "video/vivo",
	vob = "video/ms-vob",
	vor = "application/stardivision.writer",
	vox = "application/authorware-bin",
	vrml = "model/vrml",
	vsd = "application/visio",
	vsf = "application/vsf",
	vss = "application/visio",
	vst = "application/visio",
	vsw = "application/visio",
	vtu = "model/vtu",
	vxml = "application/voicexml+xml",
	w3d = "application/director",
	wad = "application/doom",
	wasm = "application/wasm",
	wav = "audio/wav",
	wax = "audio/ms-wax",
	wbmp = "image/wap.wbmp",
	wbs = "application/criticaltools.wbs+xml",
	wbxml = "application/wap.wbxml",
	wcm = "application/ms-works",
	wdb = "application/ms-works",
	wdp = "image/ms-photo",
	weba = "audio/webm",
	webm = "video/webm",
	webp = "image/webp",
	wg = "application/pmi.widget",
	wgt = "application/widget",
	wks = "application/ms-works",
	wm = "video/ms-wm",
	wma = "audio/ms-wma",
	wmd = "application/ms-wmd",
	wmf = "application/msmetafile",
	wml = "text/wap.wml",
	wmlc = "application/wap.wmlc",
	wmls = "text/wap.wmlscript",
	wmlsc = "application/wap.wmlscriptc",
	wmv = "video/ms-wmv",
	wmx = "video/ms-wmx",
	wmz = "application/ms-wmz",
	woff = "font/woff",
	woff2 = "font/woff2",
	wpd = "application/wordperfect",
	wpl = "application/ms-wpl",
	wps = "application/ms-works",
	wqd = "application/wqd",
	wri = "application/mswrite",
	wrl = "model/vrml",
	wsdl = "application/wsdl+xml",
	wspolicy = "application/wspolicy+xml",
	wtb = "application/webturbo",
	wvx = "video/ms-wvx",
	x32 = "application/authorware-bin",
	x3d = "model/x3d+xml",
	x3db = "model/x3d+binary",
	x3dbz = "model/x3d+binary",
	x3dv = "model/x3d+vrml",
	x3dvz = "model/x3d+vrml",
	x3dz = "model/x3d+xml",
	xaml = "application/xaml+xml",
	xap = "application/silverlight-app",
	xar = "application/xara",
	xbap = "application/ms-xbap",
	xbd = "application/fujixerox.docuworks.binder",
	xbm = "image/xbitmap",
	xdf = "application/xcap-diff+xml",
	xdm = "application/syncml.dm+xml",
	xdp = "application/adobe.xdp+xml",
	xdssc = "application/dssc+xml",
	xdw = "application/fujixerox.docuworks",
	xenc = "application/xenc+xml",
	xer = "application/patch-ops-error+xml",
	xfdf = "application/adobe.xfdf",
	xfdl = "application/xfdl",
	xht = "application/xhtml+xml",
	xhtml = "application/xhtml+xml",
	xhvml = "application/xv+xml",
	xif = "image/xiff",
	xla = "application/ms-excel",
	xlam = "application/ms-excel.addin.macroenabled.12",
	xlc = "application/ms-excel",
	xlf = "application/xliff+xml",
	xlm = "application/ms-excel",
	xls = "application/ms-excel",
	xlsb = "application/ms-excel.sheet.binary.macroenabled.12",
	xlsm = "application/ms-excel.sheet.macroenabled.12",
	xlsx = "application/openxmlformats-officedocument.spreadsheetml.sheet",
	xlt = "application/ms-excel",
	xltm = "application/ms-excel.template.macroenabled.12",
	xltx = "application/openxmlformats-officedocument.spreadsheetml.template",
	xlw = "application/ms-excel",
	xm = "audio/xm",
	xml = "application/xml",
	xo = "application/olpc-sugar",
	xop = "application/xop+xml",
	xpak = "application/gentoo.xpak",
	xpi = "application/xpinstall",
	xpl = "application/xproc+xml",
	xpm = "image/xpixmap",
	xpr = "application/is-xpr",
	xps = "application/ms-xpsdocument",
	xpw = "application/intercon.formnet",
	xpx = "application/intercon.formnet",
	xsl = "application/xml",
	xslt = "application/xslt+xml",
	xsm = "application/syncml+xml",
	xspf = "application/xspf+xml",
	xul = "application/mozilla.xul+xml",
	xvm = "application/xv+xml",
	xvml = "application/xv+xml",
	xwd = "image/xwindowdump",
	xyz = "chemical/xyz",
	xz = "application/xz",
	yaml = "text/yaml",
	yang = "application/yang",
	yin = "application/yin+xml",
	yml = "text/yaml",
	z1 = "application/zmachine",
	z2 = "application/zmachine",
	z3 = "application/zmachine",
	z4 = "application/zmachine",
	z5 = "application/zmachine",
	z6 = "application/zmachine",
	z7 = "application/zmachine",
	z8 = "application/zmachine",
	zaz = "application/zzazz.deck+xml",
	zip = "application/zip",
	zir = "application/zul",
	zirz = "application/zul",
	zmm = "application/handheld-entertainment+xml",
	zsh = "text/shellscript",
}

local options = ya.sync(
	function(st)
		return {
			with_files = st.with_files,
			with_exts = st.with_exts,
			fallback_file1 = st.fallback_file1,
		}
	end
)

local M = {}

function M:setup(opts)
	opts = opts or {}

	self.with_files = opts.with_files
	self.with_exts = opts.with_exts
	self.fallback_file1 = opts.fallback_file1
end

function M:fetch(job)
	local opts = options()
	local merged_files = ya.dict_merge(FILES, opts.with_files or {})
	local merged_exts = ya.dict_merge(EXTS, opts.with_exts or {})

	local updates, unknown, state = {}, {}, {}
	for i, file in ipairs(job.files) do
		if file.cha.is_dummy then
			state[i] = false
			goto continue
		end

		local mime
		if file.cha.len == 0 then
			mime = "inode/empty"
		else
			mime = merged_files[(file.url:name() or ""):lower()]
			mime = mime or merged_exts[(file.url:ext() or ""):lower()]
		end

		if mime then
			updates[tostring(file.url)], state[i] = mime, true
		elseif opts.fallback_file1 then
			unknown[#unknown + 1] = file
		else
			updates[tostring(file.url)], state[i] = "application/octet-stream", true
		end
		::continue::
	end

	if next(updates) then
		ya.mgr_emit("update_mimes", { updates = updates })
	end

	if #unknown > 0 then
		return self.fallback_builtin(job, unknown, state)
	end

	return state
end

function M.fallback_builtin(job, unknown, state)
	local indices = {}
	for i, f in ipairs(job.files) do
		indices[f:hash()] = i
	end

	local result = require("mime"):fetch(ya.dict_merge(job, { files = unknown }))
	for i, f in ipairs(unknown) do
		if type(result) == "table" then
			state[indices[f:hash()]] = result[i]
		else
			state[indices[f:hash()]] = result
		end
	end
	return state
end

return M
