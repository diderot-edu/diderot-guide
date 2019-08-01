-- This script promotes the language attribute of a pandoc
-- codeBlock to a class.  
-- This should allows using custom languages with 
-- Kate (XML) specifications.

function CodeBlock(block)
  
  l = block.attributes['language']
  -- if no language is defined 
  -- then no change necessary.
  -- else make the language a class.
  if l == nil then
    return block
  else  
    -- delete language atttribute
    block.attributes['language'] = nil

    -- make lang a class, lua counts from 1.
    table.insert (block.classes, 1, l)

    return block
  end
end
