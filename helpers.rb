def err(msg)
  # abort(msg.gsub(Regexp.new("^(#{$1||' '}+)( *)"),'\2').strip)
  msg = msg.sub(/(^ +)/,'')
  abort(msg.gsub($1,'').strip)
end