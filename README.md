# Walk

Walk is a simple tool to explore a directory tree, inspired by [python os.walk][1]. For each directory (and subdirectories) it give path, files and directories.

During the exploration, it don't go down into unreadable directories, and ignore content which have disappeared.

Unlike python walk, there is no error callback (now).

## Usage

The Walk.walk function require at least the root of the tree to explore. It can be used with a code block which is called for each directory and receiving 3 arguments : the full path of the current directory, the directories, and the files inside the current directory.

    require 'walk'
     
    Walk.walk('/') do |path, dirs, files|
      puts "In #{path} there are #{dirs.length} directories and #{files.length} files"
    end

Without a block, Walk.walk return an enumerator :

    require 'walk'
    
    # Directories containing a least 10 files
    puts Walk.walk('/')
      .select { |path,dirs,files| files.length>=10 }
      .map { |path,_,_| path }

Optional (keywords) arguments are :

 - topdown : when true (default) the content is returned from top to bottom during tree exploration. When topdown is false, the content is returned beginning with the bottom.
 - followlinks : when false (default) it doesn't explore subdirectories which are symbolic links. When followlinks is true, it can produce an infinite loop in some cases.

## Licence

Walk is released under the MIT license. See LICENSE.txt file for details.

  [1]: http://docs.python.org/3.3/library/os.html#os.walk