#!/usr/bin/env node

var path = require('path'),
    fs = require('fs'),
    sys = require('util'),
    os = require('os'),
    mkdirp;

var less = require('../lib/less');
var args = process.argv.slice(1);
var options = {
    depends: false,
    compress: false,
    yuicompress: false,
    max_line_len: -1,
    optimization: 1,
    silent: false,
    verbose: false,
    lint: false,
    paths: [],
    color: true,
    strictImports: false,
    rootpath: '',
    relativeUrls: false,
    ieCompat: true,
    strictMath: false,
    strictUnits: false
};
var continueProcessing = true,
    currentErrorcode;

// calling process.exit does not flush stdout always
// so use this to set the exit code
process.on('exit', function() { process.reallyExit(currentErrorcode) });

var checkArgFunc = function(arg, option) {
    if (!option) {
        sys.puts(arg + " option requires a parameter");
        continueProcessing = false;
        return false;
    }
    return true;
};

var checkBooleanArg = function(arg) {
    var onOff = /^((on|t|true|y|yes)|(off|f|false|n|no))$/i.exec(arg);
    if (!onOff) {
        sys.puts(" unable to parse "+arg+" as a boolean. use one of on/t/true/y/yes/off/f/false/n/no");
        continueProcessing = false;
        return false;
    }
    return Boolean(onOff[2]);
};

args = args.filter(function (arg) {
    var match;

    if (match = arg.match(/^-I(.+)$/)) {
        options.paths.push(match[1]);
        return false;
    }

    if (match = arg.match(/^--?([a-z][0-9a-z-]*)(?:=([^\s]*))?$/i)) { arg = match[1] }
    else { return arg }

    switch (arg) {
        case 'v':
        case 'version':
            sys.puts("lessc " + less.version.join('.') + " (LESS Compiler) [JavaScript]");
            continueProcessing = false;
        case 'verbose':
            options.verbose = true;
            break;
        case 's':
        case 'silent':
            options.silent = true;
            break;
        case 'l':
        case 'lint':
            options.lint = true;
            break;
        case 'strict-imports':
            options.strictImports = true;
            break;
        case 'h':
        case 'help':
            require('../lib/less/lessc_helper').printUsage();
            continueProcessing = false;
        case 'x':
        case 'compress':
            options.compress = true;
            break;
        case 'M':
        case 'depends':
            options.depends = true;
            break;
        case 'yui-compress':
            options.yuicompress = true;
            break;
        case 'max-line-len':
            if (checkArgFunc(arg, match[2])) {
                options.maxLineLen = parseInt(match[2], 10);
                if (options.maxLineLen <= 0) {
                  options.maxLineLen = -1;
                }
            }
            break;
        case 'no-color':
            options.color = false;
            break;
        case 'no-ie-compat':
            options.ieCompat = false;
            break;
        case 'include-path':
            if (checkArgFunc(arg, match[2])) {
                options.paths = match[2].split(os.type().match(/Windows/) ? ';' : ':')
                    .map(function(p) {
                        if (p) {
                            return path.resolve(process.cwd(), p);
                        }
                    });
            }
            break;
        case 'O0': options.optimization = 0; break;
        case 'O1': options.optimization = 1; break;
        case 'O2': options.optimization = 2; break;
        case 'line-numbers':
            if (checkArgFunc(arg, match[2])) {
                options.dumpLineNumbers = match[2];
            }
            break;
        case 'rp':
        case 'rootpath':
            if (checkArgFunc(arg, match[2])) {
                options.rootpath = match[2].replace(/\\/g, '/');
            }
            break;
        case "ru":
        case "relative-urls":
            options.relativeUrls = true;
            break;
        case "sm":
        case "strict-math":
            if (checkArgFunc(arg, match[2])) {
                options.strictMath = checkBooleanArg(match[2]);
            }
            break;
        case "su":
        case "strict-units":
            if (checkArgFunc(arg, match[2])) {
                options.strictUnits = checkBooleanArg(match[2]);
            }
            break;
    }
});

if (!continueProcessing) {
    return;
}

var input = args[1];
var inputbase = args[1];
if (input && input != '-') {
    input = path.resolve(process.cwd(), input);
}
var output = args[2];
var outputbase = args[2];
if (output) {
    output = path.resolve(process.cwd(), output);
}

if (! input) {
    sys.puts("lessc: no input files");
    sys.puts("");
    require('../lib/less/lessc_helper').printUsage();
    currentErrorcode = 1;
    return;
}

var ensureDirectory = function (filepath) {
    var dir = path.dirname(filepath),
        cmd,
        existsSync = fs.existsSync || path.existsSync;
    if (!existsSync(dir)) {
        if (mkdirp === undefined) {
            try {mkdirp = require('mkdirp');}
            catch(e) { mkdirp = null; }
        }
        cmd = mkdirp && mkdirp.sync || fs.mkdirSync;
        cmd(dir);
    }
};

if (options.depends) {
    if (!outputbase) {
        sys.print("option --depends requires an output path to be specified");
        return;
    }
    sys.print(outputbase + ": ");
}

var parseLessFile = function (e, data) {
    if (e) {
        sys.puts("lessc: " + e.message);
        currentErrorcode = 1;
        return;
    }

    options.paths = [path.dirname(input)].concat(options.paths);
    options.filename = input;

    var parser = new(less.Parser)(options);
    parser.parse(data, function (err, tree) {
        if (err) {
            less.writeError(err, options);
            currentErrorcode = 1;
            return;
        } else if (options.depends) {
            for(var file in parser.imports.files) {
                sys.print(file + " ")
            }
            sys.print("\n");
        } else if(!options.lint) {
            try {
                var css = tree.toCSS({
                    silent: options.silent,
                    verbose: options.verbose,
                    ieCompat: options.ieCompat,
                    compress: options.compress,
                    yuicompress: options.yuicompress,
                    maxLineLen: options.maxLineLen,
                    strictMath: options.strictMath,
                    strictUnits: options.strictUnits
                });
                if (output) {
                    ensureDirectory(output);
                    fs.writeFileSync(output, css, 'utf8');
                    if (options.verbose) {
                        console.log('lessc: wrote ' + output);
                    }
                } else {
                    sys.print(css);
                }
            } catch (e) {
                less.writeError(e, options);
                currentErrorcode = 2;
                return;
            }
        }
    });
};

if (input != '-') {
    fs.readFile(input, 'utf8', parseLessFile);
} else {
    process.stdin.resume();
    process.stdin.setEncoding('utf8');

    var buffer = '';
    process.stdin.on('data', function(data) {
        buffer += data;
    });

    process.stdin.on('end', function() {
        parseLessFile(false, buffer);
    });
}
