-- This script deletes spans consisting of just a label.
-- To do this, we check that it has no valid class
-- and then check the label against the identifier.
-- If they are both the same we consider this span to be
-- a label span.
-- For example:
--   <span id="def:a" label="def:a">[def:a]</span> 

function Span(block)
  if block.attributes['class'] == nil then  
    l = block.attributes['label']
    id = block.identifier
    -- if no label is defined
    -- then no change necessary.
    -- else check that the block text is same as label
    -- if so, then delete, else skip.
    if l == nil then
      -- print ('label not found')
      return block
    else  
      if id == l then
        -- delete this block
        -- print ('deleted id =', id)
        return {}
      else
        -- print ('kept id =', id)
        return block
      end
    end
  else 
    -- if span has a non-empty class return it unmodified.
    -- print ('class found')
    return block
  end
end
