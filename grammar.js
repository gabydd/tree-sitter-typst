function zebra(zeb, ra) {
  return seq(optional(ra), (repeat(seq(zeb, ra))), optional(zeb));
}
function ws($) {
  return repeat(choice($._space_expr, $.comment));
}
function ws1($) {
  return repeat1(choice($._space_expr, $.comment));
}
function content($) {
  return zebra(choice($.break, $._new_line), choice($.heading, repeat1($._markup)));
}
function inside($) {
  return zebra($._new_line, choice(seq($.heading, $._new_line), prec.left(repeat1($._markup))));
}
module.exports = grammar({
  name: 'typst',
  extras: $ => [],
  conflicts: $ => [
    // [$.block],
    [$._code],
    [$.let],
    [$.import],
    [$.elude],
    [$.return],
    [$.tagged, $._expr],
    [$.tagged, $._expr, $._pattern],
    [$._expr, $._pattern],
    [$._item, $._expr],
    [$._code, $.field],
    [$.or, $.not, $.and, $.cmp, $.in, $.add, $.sub, $.mul, $.div],
    [$.or, $.and, $.cmp, $.in, $.add, $.sub, $.mul, $.div],
  ],
  rules: {
    source_file: $ => content($),

    _token_dlim: $ => /[ ]*(\n|;)/,
    _token_dlim_blck: $ => token(prec(1, /[ ]*(\n|;)/)),
    break: $ => /\n([ \t]*\n)+/,
    escape: $ => /\\[^\nu]|\\u\{[0-9a-fA-F]*\}/,
    comment: $ => choice(
      seq('//', /[^\n]*\n?/),
      seq('/*', repeat(choice(/[^\*\/]|\*[^\/]|\/[^\/\*]/, $.comment)), '*/'),
    ),

    _space_expr: $ => /[ \n\t]+/,
    _new_line: $ => /\n/,
    _space_text: $ => /[ \t]+/,

    _anti_else: $ => /[ \n\t]*else[^ \t\{\[]/,
    _anti_markup: $ => /[\p{L}0-9][_\*][\p{L}0-9]/,
    // _anti_head: $ => /[^\n][ \t]*=+[^ \t]/,

    _token_head: $ => /=+/,
    _token_else: $ => /[ \n\t]*else/,
    // _token_plus: $ => /[ \n\t]*\+/,
    // _token_not:  $ => /[ \n\t]*not/,
    // _token_and:  $ => /[ \n\t]*and/,
    // _token_or:   $ => /[ \n\t]*or/,
    // _token_dash: $ => /[ \n\t]*\-/,
    // _token_star: $ => /[ \n\t]*\*/,
    // _token_slsh: $ => /[ \n\t]*\//,
    // _token_part: $ => /[ \n\t]*(not[ \n\t]*)?in/,
    // _token_comp: $ => /[ \n\t]*(<|>|<=|>=|==|!=)/,
    // _token_lmdb: $ => /[ \n\t]*=>/,
    _token_dot: $ => /\./,
    line: $ => /\\/,

    _char_any: $ => /./,

    _markup: $ => choice(
      $._code,
      $.text,
      $.strong,
      $.emph,
      $._space_text,
      $.comment,
      $.raw_blck,
      $.raw_span,
      $.math,
    ),
    _markup_inside: $ => choice(
      $._code,
      $.text,
      $.strong,
      $.emph,
      $._space_text,
      $._new_line,
      $.comment,
      $.raw_blck,
      $.raw_span,
      $.math,
    ),

    text: $ => prec.right(repeat1(choice(
      $._anti_else,
      $._anti_markup,
      $._token_dot,
      $._char_any,
      $.escape,
      $.line,
    ))),

    heading: $ => seq($._token_head, repeat($._markup)),
    strong: $ => prec.left(seq('*', inside($), '*')),
    emph: $ => prec.left(seq('_', inside($), '_')),
    math: $ => seq('$', /[^\$]*/, '$'),
    raw_blck: $ => seq('```', field('lang', optional($.ident)), alias(/[^`a-zA-Z](``[^`]|`[^`]|[^`])*/, $.blob), '```'),
    raw_span: $ => seq('`', alias(/[^`]*/, $.blob), '`'),

    _code: $ => seq('#', choice($._item, $._stmt), optional($._token_dlim)),

    _item: $ => prec(1, choice(
      $.auto,
      $.none,
      $.builtin,
      $.ident,
      $.label,
      $.bool,
      $.number,
      $.string,
      $.branch,
      $.field,
      $.block,
      $.group,
      $.call,
      $.content,
    )),

    _stmt: $ => choice(
      $.let,
      $.set,
      $.import,
      $.include,
      $.for,
      $.while,
      $.show,
      $.return,
    ),

    _expr: $ => choice(
      $.auto,
      $.none,
      $.builtin,
      $.ident,
      $.label,
      $.bool,
      $.number,
      $.string,
      $.branch,
      $.field,
      $.block,
      $.group,
      $.elude,
      $.lambda,
      $.not,
      $.or,
      $.and,
      $.cmp,
      $.in,
      $.add,
      $.sub,
      $.mul,
      $.div,
      $.sign,
      $.call,
      $.content,
      $.let,
      $.set,
      $.import,
      $.include,
      $.for,
      $.while,
      $.show,
      $.return,
    ),

    _pattern: $ => choice(
      $.ident,
      $.group,
    ),

    ident: $ => /[\p{XID_Start}_][\p{XID_Continue}\-]*/,
    unit: $ => choice('cm', 'mm', 'em', '%', 'fr', 'pt', 'in'),
    bool: $ => choice('true', 'false'),
    number: $ => prec.right(seq(/[0-9]+(\.[0-9]+)?/, optional($.unit))),
    string: $ => seq('"', repeat(choice(/[^\"\\]/, $.escape)), '"'),
    // elude and lambda have strange behavior if no optional space place at the end
    // see test 139 and 140
    elude:  $ =>      prec(2, seq('..', optional(seq(ws($), $._expr)), ws($))),
    lambda: $ => prec.right(3, seq(field('pattern', $._pattern), ws($), '=>', ws($), field('value', $._expr), ws($))),
    or:     $ => prec.left(4, seq($._expr, ws($), 'or', ws($), $._expr)),
    not:    $ => prec.left(5, seq('not', ws($), $._expr)),
    and:    $ => prec.left(5, seq($._expr, ws($), 'and', ws($), $._expr)),
    cmp:    $ => prec.left(6, seq($._expr, ws($), choice('<', '>', '<=', '>=', '==', '!='), ws($), $._expr)),
    // FIXME: `not in` with comments and spaces
    in:     $ => prec.left(7, seq($._expr, ws($), choice('not in', 'in'), ws($), $._expr)), 
    add:    $ => prec.left(8, seq($._expr, ws($), '+', ws($), $._expr)),
    sub:    $ => prec.left(8, seq($._expr, ws($), '-', ws($), $._expr)),
    mul:    $ => prec.left(9, seq($._expr, ws($), '*', ws($), $._expr)),
    div:    $ => prec.left(9, seq($._expr, ws($), '/', ws($), $._expr)),
    sign:   $ =>      prec(10, seq(choice('+', '-'), ws($), $._expr)),

    call:   $ => seq(field('item', $._item), choice($.content, $.group)),
    field:  $ => seq($._item, $._token_dot, field('field', $.ident)),
    tagged: $ => seq(field('field', $.ident), ws($), ':', ws($), $._expr),
    label: $ => seq('<', /[\p{XID_Start}\-_][\p{XID_Continue}\-_]*/, '>'),
    content: $ => seq('[', content($), ']'),
    group: $ => seq(
      '(',
      repeat(seq(
        ws($),
        choice($.tagged, $._expr),
        ws($),
        ','
      )),
      ws($),
      optional(seq(choice($.tagged, $._expr), ws($))),
      ')'
    ),
    block: $ => seq(
      '{',
      repeat(seq(
        prec.left(optional(choice($._expr, $.comment))),
        // this token as the precedence over regular new lines inside expression
        // that way, a new line is a separator between expressions
        $._token_dlim_blck,
        optional($._space_expr),
      )),
      optional(choice($._expr, $.comment)),
      '}'
    ),
    branch: $ => prec.left(2, seq(
      'if',
      ws($), 
      field('test', $._expr), 
      ws($),
      choice($.block, $.content),
      optional(seq($._token_else,
        ws($),
        choice($.block, $.content, $.branch)
      )),
    )),
    let: $ => prec(0, seq(
      'let',
      ws($),
      field('pattern', choice($._pattern, $.call)),
      optional(seq(
        ws($),
        '=',
        ws($),
        field('value', $._expr)
      )),
      ws($),
    )),
    set: $ => prec(0, seq(
      'set',
      ws($),
      $.call,
    )),
    import: $ => prec(0, seq(
      'import',
      ws($),
      $.string,
      optional(seq(
        ws($),
        ':',
        repeat(seq(ws($), $.ident, ws($), ',')),
        optional(seq(ws($), $.ident)),
      )),
    )),
    include: $ => prec(0, seq(
      'include',
      ws($),
      $.string,
    )),
    for: $ => seq(
      'for',
      ws($),
      field('pattern', $._pattern),
      ws($),
      'in',
      ws($),
      field('value', $._expr),
      ws($),
      choice($.block, $.content),
    ),
    while: $ => seq(
      'while',
      ws($),
      field('test', $._expr),
      ws($),
      choice($.block, $.content),
    ),
    show: $ => seq(
      'show',
      ws($),
      optional(seq(
        field('pattern', $._expr),
        ws($),
      )),
      ':',
      ws($),
      field('value', $._expr),
    ),
    return: $ => seq('return', optional(seq(ws($), $._expr))),
    auto: $ => 'auto',
    none: $ => 'none',
    builtin: $ => choice(
      'align',
      'black',
      'blue',
      'bottom',
      'box',
      'center',
      'cmyk',
      'emph',
      'gray',
      'green',
      'grid',
      'h',
      'heading',
      'horizon',
      'image',
      'left',
      'link',
      'list',
      'luma',
      'max',
      'min',
      'navy',
      'par',
      'parbreak',
      'purple',
      'rect',
      'red',
      'regex',
      'rgb',
      'right',
      'scale',
      'strong',
      'text',
      'top',
      'v',
      'white',
    ),
  },
});

