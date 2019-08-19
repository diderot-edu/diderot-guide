-- This function has two parts
-- Part I promotes the language attribute of a pandoc
-- codeBlock to a class. This allows using custom languages with 
-- Kate (XML) specifications.
-- Part II promotes certain html code blocks to raw html.
-- It is used to implement diderot commands.

function CodeBlock(block)
  
  -- Part I
  -- This function promotes the language attribute of a pandoc
  -- codeBlock to a class.  
  -- This should allows using custom languages with 
  -- Kate (XML) specifications.

  l = block.attributes['language']
  -- if no language is defined 
  -- then no change necessary.
  -- else make the language a class.  
  if l == nil then
    -- pass
    do
    end
  else
    -- delete language atttribute
    block.attributes['language'] = nil

    -- make lang a class, lua counts from 1.
    table.insert (block.classes, 1, l)

    return block
  end


  -- Part II
  -- This function includes the contents of a code block as raw html
  -- if it starts with %%% diderot_html tag
  -- It is used to implement diderot command such as 
  -- \download and \attach
  -- print ('block.text =', block.text) 

  -- Regex explanation
  -- ^ mathches start of string
  -- %% matches "%", % is special char and used for escapes
  -- %s matches space
  -- (.*) mathes anything and returns as a group

  local html_body = string.match (block.text, "^%%%%%%%% diderot_html%s*\n(.*)")
  -- print ('html_body =', html_body) 
  if html_body then
    return pandoc.RawBlock('html', html_body)
  end
end


-- This function deletes spans consisting of just a label.
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
